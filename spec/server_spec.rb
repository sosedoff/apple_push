require 'spec_helper'

describe ApplePush::Server do
  it 'responds with json' do
    get '/'
    last_response.should be_ok
    last_response.content_type.should eq("application/json;encoding=utf8, charset=utf-8")
  end

  it 'responds with version' do
    get '/'
    last_response.should be_ok
    resp = decode_json(last_response.body)
    resp.should be_a Hash
    resp['version'].should eq(ApplePush::VERSION)
  end

  it 'responds with error on invalid route' do
    get '/foo'
    last_response.should_not be_ok
    decode_json(last_response.body).should eq({'error' => 'Invalid request path'})
  end

  it 'requires an apn token for delivery' do
    post '/sandbox'
    last_response.should_not be_ok
    decode_json(last_response.body).should eq({'error' => 'APN token required'})
  end

  it 'required a data payload for delivery' do
    post '/sandbox?token=TOKEN'
    last_response.should_not be_ok
    decode_json(last_response.body).should eq({'error' => 'Payload required'})
  end

  it 'requires a proper json payload for request' do
    post '/sandboxy?token=TOKEN', "Invalid Data"
    last_response.should_not be_ok
    decode_json(last_response.body).should eq({'error' => 'Invalid payload. Should be JSON'})

    post '/sandbox?token=TOKEN', encode_json(:alert => "Hello")
    last_response.should_not be_ok
    decode_json(last_response.body).should eq({'error' => 'Sandbox is not configured.'})
  end
end