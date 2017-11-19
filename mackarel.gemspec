# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mackarel/version'

Gem::Specification.new do |spec|
  spec.name          = "mackarel"
  spec.version       = Mackarel::VERSION
  spec.authors       = ["Paolo Gianrossi"]
  spec.email         = ["paolino.gianrossi@gmail.com"]

  spec.summary       = %q{Simple feature testing for Rails with Capybara and Rspec}
  spec.description   = %q{Mackarel allows you to write acceptance tests in Rails in a readable way without having to deal with things like Cucumber. It uses feature tests with RSpec, FactoryBot as the factory for models, and generally follows my setup.}
  spec.homepage      = "https://github.com/paologianrossi/mackarel"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "sinatra"
  spec.add_development_dependency "tilt"
  spec.add_development_dependency "rack"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "byebug"

  spec.add_dependency "rspec", "~> 3"
  spec.add_dependency "capybara", "~> 2"
  spec.add_dependency "poltergeist", "~> 1"
  spec.add_dependency "factory_bot", "~> 4"
  spec.add_dependency "activesupport", "~> 5"

end
