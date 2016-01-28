# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'terastream/version'

Gem::Specification.new do |spec|
  spec.name          = "terastream"
  spec.version       = Terastream::VERSION
  spec.authors       = ["Ramin Keene", "David Von Lehman"]
  spec.email         = ["Ramin.Keene@nordstrom.com"]

  spec.summary       = %q{ Stream query results out of teradata data warehouse}
  spec.description   = %q{ Utility gem to stream teradata results out of the teradata data warehouse, supporting adaptors for various formats and destinations}
  spec.homepage      = "http://github.com/Nordstrom/terastream"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.platform = 'java'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables  << 'terasql'

  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk", "~> 2"
  spec.add_dependency "json", "~> 1.8.0"
  spec.add_dependency "poseidon", "~> 0.0.5"
  spec.add_dependency "redis", "~> 3.2.1"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
end
