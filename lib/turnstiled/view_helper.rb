# frozen_string_literal: true

module Turnstiled
  module ViewHelper
    # `size` and `theme` reach the widget as Stimulus values rather than as the
    # `data-size`/`data-theme` attributes Cloudflare documents: the script is
    # loaded with `render=explicit`, and in that mode the widget is drawn from
    # the object passed to `turnstile.render` and never reads the element.
    def turnstile_tag(size: "compact", theme: "auto", **options)
      options = options.deep_merge(
        class: "cf-turnstile #{options[:class]}",
        data: {
          sitekey: Turnstiled.site_key,
          controller: "turnstile",
          turnstile_site_key_value: Turnstiled.site_key,
          turnstile_size_value: size,
          turnstile_theme_value: theme,
          size:
        }
      )

      content_tag(:div, "", options)
    end

    def turnstile_javascript_tag
      if ::Turnstiled.mock
        javascript_include_tag("turnstiled/mock_turnstile_widget.js", defer: true, data: { turbo_track: "reload" })
      else
        javascript_include_tag("https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit",
                               defer: true,
                               data: {
                                 turbo_track: "reload"
                               })
      end
    end
  end
end
