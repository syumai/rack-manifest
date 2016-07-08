class Rack::Manifest::Railtie < Rails::Railtie
  initializer "rack-manifest.initialize"  do |app|
    app.config.middleware.insert_after Rack::MethodOverride, Rack::Manifest
  end
end
