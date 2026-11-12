# frozen_string_literal: true

module Turnstiled
  module ControllerMethods
    extend ActiveSupport::Concern

    class_methods do
      def verify_turnstile_request(with: -> { head :bad_request }, **, &block)
        with = block if block
        before_action -> { verify_turnstile_request(with) }, **
      end
    end

    private

    def verify_turnstile_request(handler)
      return if Turnstiled.verify(request)

      handler.is_a?(Symbol) ? send(handler) : instance_exec(&handler)
    end
  end
end
