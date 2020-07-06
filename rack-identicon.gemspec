require_relative 'lib/rack/identicon/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-identicon"
  spec.version       = Rack::Identicon::VERSION
  spec.authors       = ["glaszig"]
  spec.email         = ["glaszig@gmail.com"]

  spec.summary       = %q{Generates Identicon for arbitrary data on the fly.}
  spec.description   = %q{Gives you a Rack middleware to generate pictures representing data, like gravatar does.}
  spec.homepage      = "https://github.com/glaszig/rack-identicon"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'identicon'
  spec.add_development_dependency 'rack-test'
end
