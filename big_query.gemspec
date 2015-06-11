# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yancya/big_query/version'

Gem::Specification.new do |spec|
  spec.name          = "yancya-big_query"
  spec.version       = Yancya::BigQuery::VERSION
  spec.authors       = ["yancya"]
  spec.email         = ["yancya@upec.jp"]
  spec.summary       = %q{Google BigQuery API client library.}
  spec.description   = %q{Google BigQuery API client library. This is simple wrapper.}
  spec.homepage      = "https://github.com/yancya/big_query"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "google-api-client"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
end
