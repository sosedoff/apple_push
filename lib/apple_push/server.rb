require 'sinatra/base'
require 'multi_json'
require 'apple_push/version'

module ApplePush
  class Server < Sinatra::Base
    set :environment, ENV['RACK_ENV'] || 'production'
    
    helpers do
      def json_response(data)
        MultiJson.encode(data)
      end
      
      def error_response(error, status=400)
        halt(400, json_response(:error => error))
      end
      
      def process_payload
        @token   = params[:token].to_s.strip
        @payload = request.body.read
        
        error_response("APN token required") if @token.empty?
        error_response("Payload required")   if @payload.empty?
        
        begin
          @payload = MultiJson.decode(@payload)
        rescue MultiJson::DecodeError
          error_response("Invalid payload. Should be JSON", 422)
        end
      end
    
      def deliver(env, token, payload={})
        unless ApplePush.pool?(env)
          error_response("#{env.capitalize} is not configured.")
        end
        
        notification = EM::APN::Notification.new(token, payload)
        ApplePush.pool(env).with_connection do |apn|
          apn.deliver(notification)
        end
      end
    end
    
    before do
      content_type :json, :encoding => :utf8
    end
    
    error do
      err = env['sinatra.error']
      content_type :json, :encoding => :utf8
      json_response(:error => {:message => err.message, :type => err.class.to_s})
    end
    
    not_found do
      json_response(:error => "Invalid request path")
    end
    
    get '/' do
      "{\"version\":\"#{ApplePush::VERSION}\"}"
    end
    
    post %r{/(sandbox|live)} do |mode|
      process_payload
      deliver(mode, @token, @payload)
      '{"delivered":true}'
    end
  end
end