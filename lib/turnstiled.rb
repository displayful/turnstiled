require "faraday"

module Turnstiled
  autoload :ControllerMethods, "turnstiled/controller_methods"
  autoload :ViewHelper, "turnstiled/view_helper"
  autoload :Verifier, "turnstiled/verifier"
  autoload :VERSION, "turnstiled/version"

  mattr_accessor :site_key
  mattr_accessor :site_secret
  mattr_accessor :mock, default: Rails.env.local?

  def self.verify(request)
    Verifier.new.verify(request)
  end
end

require "turnstiled/engine" if defined?(Rails)
