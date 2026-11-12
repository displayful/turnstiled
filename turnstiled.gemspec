require_relative "lib/turnstiled/version"

Gem::Specification.new do |spec|
  spec.name        = "turnstiled"
  spec.version     = Turnstiled::VERSION
  spec.authors     = [ "Displayful", "Henrik Hauge Bjørnskov" ]
  spec.email       = [ "hb@displayful.co" ]
  spec.license     = "MIT"
  spec.homepage    = "https://github.com/displayful/turnstiled"
  spec.summary     = "Cloudflare Turnstile for Rails"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["source_code_uri"]  = "https://github.com/displayful/turnstiled"
  spec.metadata["homepage_uri"]     = "https://github.com/displayful/turnstiled"
  spec.metadata["bug_tracker_uri"]  = "https://github.com/displayful/turnstiled/issues"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  end

  spec.required_ruby_version = Gem::Requirement.new(">= 3.3.0")

  spec.add_runtime_dependency 'rails', '>= 7.0.0'
  spec.add_dependency "faraday"
end
