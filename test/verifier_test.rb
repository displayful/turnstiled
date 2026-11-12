require "test_helper"
require "action_controller/railtie"
require "turnstiled"

class VerifierTest < ActiveSupport::TestCase
  class UnreachableVerifier < Turnstiled::Verifier
    def client
      Faraday.new do |f|
        f.adapter(:test) { |stub| stub.post("siteverify") { raise Faraday::TimeoutError } }
      end
    end
  end

  setup { Turnstiled.mock = false }
  teardown { Turnstiled.mock = true }

  test "reports an unreachable Cloudflare and fails the check" do
    request = ActionDispatch::Request.new(Rack::MockRequest.env_for("/", params: { "cf-turnstile-response" => "token" }))

    assert_error_reported(Faraday::TimeoutError) do
      assert_not UnreachableVerifier.new.verify(request)
    end
  end
end
