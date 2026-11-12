# frozen_string_literal: true

module Turnstiled
  class Verifier
    def verify(request)
      return request.params["cf-turnstile-response"] == "1" if Turnstiled.mock

      response = client.post("siteverify", {
        secret: Turnstiled.site_secret,
        response: request.params["cf-turnstile-response"],
        remoteip: request.remote_ip
      })

      response.body.fetch("success", false)
    rescue Faraday::Error => error
      Rails.error.report(error, handled: true, severity: :warning)
      false
    end

    def client
      @client ||= Faraday.new(client_options) do |f|
        f.request :json
        f.response :json
      end
    end

    def client_options
      {
        url: "https://challenges.cloudflare.com/turnstile/v0",
        request: {
          timeout: 3
        }
      }
    end
  end
end
