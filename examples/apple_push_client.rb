require 'faraday'
require 'multi_json'

class PushClient
  attr_reader :host

  def initialize(host)
    @host = host
  end

  def connection(host)
    conn = Faraday::Connection.new(host) do |c|
      c.use(Faraday::Request::UrlEncoded)
      c.adapter(Faraday.default_adapter)
    end
  end

  def notify(env, token, data)
    params = {:token => token}
    body = MultiJson.encode(data)
    path = env == 'live' ? '/live' : '/sandbox'

    response = connection(host).send(:post) do |request|
      request.path   = path
      request.params = params
      request.body   = body
    end

    response.body
  end
end

client = PushClient.new('http://localhost:27000')
client.notify('live', 'TOKEN', {:alert => "Test Message"})