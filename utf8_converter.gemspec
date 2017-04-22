# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'utf8_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'utf8_converter'
  spec.version       = UTF8Converter::VERSION
  spec.authors       = ['Jorge Del Rio']
  spec.email         = ['jdelrios@gmail.com']

  spec.summary       = 'A gem to force all kind of text into UTF8 encoding'
  spec.description   = 'This gem attempts to convert texts from unknown encodings to UTF8'
  spec.homepage      = 'https://github.com/newint33h/utf8_converter.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5'
end
