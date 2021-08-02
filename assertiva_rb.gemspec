# frozen_string_literal: true

require_relative "lib/assertiva_rb/version"

Gem::Specification.new do |spec|
  spec.name          = "assertiva_rb"
  spec.version       = AssertivaRb::VERSION
  spec.authors       = ["Fernando Caçador"]
  spec.email         = ["fernandocpdev@gmail.com"]

  spec.summary       = "Gem to use Assertiva API v2"
  spec.description   = "Gem to use Assertiva API v2"
  spec.homepage      = "http://github.com/fcpontes/assertiva_rb"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/fcpontes/assertiva_rb"
  spec.metadata["changelog_uri"] = "http://github.com/fcpontes/assertiva_rb/changelog"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  # end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 1.5"
  spec.add_dependency "faraday_middleware", "~> 1.0"
  spec.add_dependency "faraday-encoding"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
