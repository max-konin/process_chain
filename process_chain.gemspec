
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'process_chain/version'

Gem::Specification.new do |spec|
  spec.name          = 'process_chain'
  spec.version       = ProcessChain::VERSION
  spec.authors       = ['Max Konin']
  spec.email         = ['maxim21214@gmail.com']

  spec.summary       = 'Simple railway programming implamentation for Ruby'
  spec.description   = 'Simple railway programming implementation for Ruby. To allow describe business logic in Elixir style'
  spec.homepage      = 'https://github.com/max-konin/process_chain'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
