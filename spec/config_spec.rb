require 'spec_helper'

describe ApplePush::Configuration do
  it 'raises error if file was not found' do
    lambda { ApplePush::Configuration.load_file('/tmp/config.yml') }.
      should raise_error ArgumentError, 'File "/tmp/config.yml" does not exist.'
  end

  it 'raises error if config is not valid' do
    path = fixture_path('invalid_config.yml')
    lambda { ApplePush::Configuration.load_file(path) }.
      should raise_error ArgumentError, "Invalid configuration file."
  end
end