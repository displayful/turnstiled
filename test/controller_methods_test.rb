require "test_helper"
require "action_controller/railtie"
require "turnstiled"

class ControllerMethodsTest < ActiveSupport::TestCase
  class PostsController < ActionController::Base
    include Turnstiled::ControllerMethods

    verify_turnstile_request only: :create

    def create
      head :created
    end
  end

  class CommentsController < ActionController::Base
    include Turnstiled::ControllerMethods

    verify_turnstile_request with: :turnstile_failed, only: :create

    def create
      head :created
    end

    private

    def turnstile_failed
      head :unprocessable_content
    end
  end

  class RepliesController < ActionController::Base
    include Turnstiled::ControllerMethods

    verify_turnstile_request(only: :create) { head :forbidden }

    def create
      head :created
    end
  end

  test "lets a verified request through" do
    assert_equal 201, post(PostsController, "1")
  end

  test "answers bad request when the check fails" do
    assert_equal 400, post(PostsController, "0")
  end

  test "hands a failed check to the handler" do
    assert_equal 422, post(CommentsController, "0")
  end

  test "hands a failed check to the block" do
    assert_equal 403, post(RepliesController, "0")
  end

  private

  def post(controller, token)
    env = Rack::MockRequest.env_for("/", method: "POST", params: { "cf-turnstile-response" => token })
    controller.action(:create).call(env).first
  end
end
