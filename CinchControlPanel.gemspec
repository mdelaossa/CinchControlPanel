# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CinchControlPanel/version'

Gem::Specification.new do |spec|
  spec.name          = "CinchControlPanel"
  spec.version       = CinchControlPanel::VERSION
  spec.authors       = ["Mario de la Ossa"]
  spec.email         = ["mariodelaossa@gmail.com"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rack-test", "~> 0.6.3"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "capybara", "~> 2.4.4"
  spec.add_development_dependency "selenium-webdriver", "~> 2.45.0"
  spec.add_development_dependency "teaspoon", "~> 0.9.1"
  spec.add_development_dependency "phantomjs", "~> 1.9.8.0"
  spec.add_development_dependency "headless", "~> 1.0.2"

  spec.add_runtime_dependency "require_all", "~> 1.3.2"
  spec.add_runtime_dependency "cinch", "~> 2.2.4"
  spec.add_runtime_dependency "sinatra", "~> 1.4.6"
  spec.add_runtime_dependency "sinatra-assetpack", "~> 0.3.3"
  spec.add_runtime_dependency "sinatra-websocket", "~> 0.3.1"
  spec.add_runtime_dependency "sass", "~> 3.4.13"
  spec.add_runtime_dependency "recursive-open-struct", "~> 0.6.3"
end
