# frozen_string_literal: true

module Turnstiled
  module ViewHelper
    def turnstile_tag(size: "compact", **options)
      options = options.deep_merge(
        class: "cf-turnstile #{options[:class]}",
        data: {
          sitekey: Turnstiled.site_key,
          controller: "turnstile",
          turnstile_site_key_value: Turnstiled.site_key,
          size:
        }
      )

      content_tag(:div, "", options)
    end

    def turnstile_javascript_tag
      if ::Turnstiled.mock
        javascript_include_tag("turnstiled/mock_turnstile_widget.js", defer: true, data: { turnstiled: true })
      else
        javascript_include_tag(
          "https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit",
          defer: true, data: { turnstiled: true }
        )
      end
    end
  end
end
