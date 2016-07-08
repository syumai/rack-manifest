require 'yaml'
require 'json'
require 'rack/manifest/version'
require 'rack/manifest/rails' if defined?(Rails::Railtie)

module Rack
  class Manifest
    def initialize(app)
      @app = app
    end

    def call(env)
      if env[PATH_INFO] == '/manifest.json'
        manifest = YAML.load_file('./config/manifest.yml')
        json = JSON.generate(manifest)
        [
          200,
          {'Content-Type' => 'application/json'},
          [json]
        ]
      else
        @app.call(env)
      end
    end
  end
end

