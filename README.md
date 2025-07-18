Turnstiled
==========

Turnstiled makes it easy to add the Cloudflare Turnstile Captcha to your Rails app.

For development, it even inlucdes a Mock widget.

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

In your controller, you also need to verify the response with the following:

``` ruby
class PostsController < ApplicationController
  verify_turnstile_request only: %i[create]
end
```

The `verify_turnstile_request` takes the same options as a `before_action` method call.
