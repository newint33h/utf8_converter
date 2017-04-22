# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'utf8_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'utf8_converter'
  spec.version       = UTF8Converter::VERSION
  spec.authors       = ['Jorge Del Rio']
  spec.email         = ['jdelrios@gmail.com']

  spec.summary       = 'A gem to force the convertion of text in any encoding into UTF8 without' +
                       ' crashing and doing the best guess convertion'
  spec.description   = 'This gem attempts to convert the received text to UTF8. It works by trying to' +
                       ' convert the given text with a list of possible common encodings. This is' +
                       ' useful if the developer knows the most common encodings that the application' +
                       ' is going to be receiving, leaving the guessing work to this gem and by safely' +
                       ' converting (without crash) the received text.'
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
