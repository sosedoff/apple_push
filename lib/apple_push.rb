require 'connection_pool'
require 'em-apn'

require 'apple_push/configuration'
require 'apple_push/server'

module ApplePush
  LIVE_URL    = 'gateway.push.apple.com'
  SANDBOX_URL = 'gateway.sandbox.push.apple.com'
  
  @@options = {}
  @@pools   = {}
  
  def self.configure(options={})
    config = ApplePush::Configuration.new(options)
    
    @@options.merge!(
      :host => config.host || '127.0.0.1',
      :port => config.port || '27000'
    )
    
    if !config.sandbox? && !config.live?
      raise ArgumentError, "At least one environment should be defined."
    end
    
    self.setup_environment('sandbox', config.sandbox) if config.sandbox?
    self.setup_environment('live', config.live)       if config.live?
  end
  
  # Get current configuration options
  #
  def self.configuration
    @@options
  end
  
  # Get a connection from pool
  #
  def self.pool(env='sandbox')
    @@pools[env]
  end
  
  # Returns true if pools is configured
  #
  def self.pool?(env)
    @@pools.key?(env)
  end
  
  private
  
  # Configure an environment
  #
  def self.setup_environment(env, config)
    raise ArgumentError, "Path to certificate file required." if !config.cert?      
    raise ArgumentError, "Path to key file required." if !config.cert_key?
  
    pool_size = Integer(config.pool || 1)
    
    @@pools[env] = ConnectionPool.new(:size => pool_size, :timeout => 5) do
      EM::APN::Client.connect(
        :gateway => env == 'live' ? LIVE_URL : SANDBOX_URL,
        :cert    => File.expand_path(config.cert),
        :key     => File.expand_path(config.cert_key)
      )
    end
  end
end
