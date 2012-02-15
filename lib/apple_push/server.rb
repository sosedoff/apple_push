require 'sinatra/base'
require 'multi_json'

module ApplePush
  class Server < Sinatra::Base
    before do
      content_type :json, :encoding => :utf8
    end
    
    helpers do
      def process_payload
        @token = params[:token].to_s.strip
        @payload = request.body.read
      
        halt 400, "APN token required" if @token.empty?
        halt 400, "Payload required" if @payload.empty?
        
        begin
          @payload = MultiJson.decode(@payload)
        rescue MultiJson::DecodeError
          halt 400, "Invalid payload. Should be JSON"
        end
      end
    
      def deliver(env, token, data={})
        unless ApplePush.pool?(env)
          halt 400, "#{env.capitalize} is not configured."
        end
        
        notification = EM::APN::Notification.new(token, data)
        ApplePush.pool(env).with_connection do |apn|
          apn.deliver(notification)
        end
      end
    end
    
    post %r{/(sandbox|live)} do |mode|
      process_payload
      deliver(mode, @token, @payload)
      '{"delivered":true}'
    end
  end
end