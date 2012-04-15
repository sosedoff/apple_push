$:.unshift File.expand_path("../..", __FILE__)

require 'lib/apple_push'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def fixture_path(target=nil)
  path = File.expand_path("../fixtures", __FILE__)
  target.nil? ? path : File.join(path, target)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end

def encode_json(data)
  MultiJson.encode(data)
end

def decode_json(data)
  MultiJson.decode(data)
end

def app
  ApplePush::Server
end