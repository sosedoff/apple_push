require File.expand_path('../lib/apple_push/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "apple_push"
  s.version     = ApplePush::VERSION.dup
  s.summary     = "Simple API to send APN notifications"
  s.description = "Sinatra-based server to deliver Apple Push Notifications"
  s.homepage    = "http://github.com/sosedoff/apple_push"
  s.authors     = ["Dan Sosedoff"]
  s.email       = ["dan.sosedoff@gmail.com"]
    
  s.add_runtime_dependency 'eventmachine',    '>= 0'
  s.add_runtime_dependency 'sinatra',         '>= 0'
  s.add_runtime_dependency 'thin',            '>= 0'
  s.add_runtime_dependency 'connection_pool', '>= 0'
  s.add_runtime_dependency 'multi_json',      '>= 0'
  s.add_runtime_dependency 'hashr',           '>= 0'
  s.add_runtime_dependency 'em-apn',          '>= 0'
  
  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables        = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.require_paths      = ["lib"]
  s.default_executable = 'apple_push'
end