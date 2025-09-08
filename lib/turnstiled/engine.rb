module Turnstiled
  class Engine < ::Rails::Engine
    initializer "turnstiled.controller" do
      ActiveSupport.on_load(:action_controller_base) { include Turnstiled::ControllerMethods }
    end

    initializer "turnstiled.view" do
      ActiveSupport.on_load(:action_view) { include Turnstiled::ViewHelper }
    end

    initializer "turnstiled.assets" do |app|
      app.config.assets.paths << root.join("app/javascript")
    end
  end
end
