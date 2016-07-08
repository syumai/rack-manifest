require 'rack/manifest/version'
require 'yaml'
require 'json'

module Rack
  class Manifest
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      if env[PATH_INFO] == '/manifest.json'
        manifest = YAML.load_file('./config/manifest.yml')
        json = JSON.generate(manifest)
        [
          200, 
          {'Content-Type' => 'application/json'},
          [json]
        ]
      else
        [status, headers, body]
      end
    end
  end
end

