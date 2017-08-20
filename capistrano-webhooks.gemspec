lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'capistrano/webhooks/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-webhooks'
  spec.version       = Capistrano::Webhooks::VERSION
  spec.authors       = ['Stanislav Fesenko']
  spec.email         = ['iamdeuterium@gmail.com']

  spec.summary       = 'Capistrano webhooks'
  spec.homepage      = 'http://iamdeuterium.ru'
  spec.license       = 'MIT'

  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'capistrano'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler'
end
