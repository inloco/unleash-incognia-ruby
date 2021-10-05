require_relative "lib/unleash/incognia/version"

Gem::Specification.new do |spec|
  spec.name          = "unleash-incognia"
  spec.version       = Unleash::Incognia::VERSION
  spec.authors       = ["Juliana Lucena"]
  spec.email         = ["juliana.lucena@incognia.com"]

  spec.summary       = "Extends Unleash Ruby client with Incognia strategies."
  spec.description   = "Extends Unleash Ruby client with Incognia strategies."
  spec.homepage      = "https://github.com/inloco/unleash-incognia/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "unleash", "~> 3.2"
end
