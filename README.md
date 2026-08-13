Turnstiled
==========

Integrate Cloudflare Turnstile into Ruby on Rails apps with ease.

For development, it even includes a Mock widget.

Getting Usage
-------------

### Installation

First install the gem by adding this line to your application's Gemfile:

``` ruby
gem "turnstiled"
```

And executing:

``` bash
$ bundle
```

### Configuration

Create a file called `config/initializers/turnstiled.rb` and add the following:

``` ruby
Turnstiled.site_key = "YOUR SITE KEY"
Turnstiled.site_secret = "YOUR SITE SECRET"
```

In your layout, add the widget to the head of the document:

``` erb
<%= turnstile_javascript_tag %>
```

In test and development, it will include a mock widget that fires the callback after 2 seconds.

The mock widget will send the `cf-turnstile-response` parameter with a value of `1`.

Within a form make sure to render the widget:

``` erb
<%= form_with model: @some_model do %>
  <%= turnstile_tag %>
<% end %>
```

`turnstile_tag` takes Cloudflare's `size` and `theme`, and passes anything else
to the `div` it renders:

``` erb
<%= turnstile_tag size: "flexible", theme: "light", class: "rounded-md" %>
```

`size` is one of `normal`, `flexible` or `compact`, and defaults to `compact`.
`theme` is one of `auto`, `light` or `dark`, and defaults to `auto` — which
follows the visitor's operating system, so a site with no dark mode of its own
should say `light` rather than take a dark widget on a light page.

In your controller, you also need to verify the response with the following:

``` ruby
class PostsController < ApplicationController
  verify_turnstile_request only: %i[create]
end
```

The `verify_turnstile_request` takes the same options as a `before_action` method call.

### Releasing

Change the version in `lib/turnstiled/version.rb` and then run `bundle` to make sure that `Gemfile.lock` is
updated with the new version.

The gem is automatically released when pushed to main on GitHub
