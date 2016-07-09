require 'json'
require 'erb'
require "digest/md5"
require 'rack/manifest/version'
require 'rack/manifest/rails' if defined?(Rails::Railtie)
require 'rack/manifest/sprockets' if defined?(Sprockets) && defined?(Rails)

class Rack::Manifest
  FILE_PATH = './config/manifest.yml'

  if defined?(Sprockets) && defined?(Rails)
    include Rack::Manifest::Sprockets
  else
    def load_yaml path
      YAML.load(ERB.new(File.read(path)).result)
    end
  end

  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] == '/manifest.json'
      manifest = load_yaml(FILE_PATH)
      json = JSON.generate(manifest)
      etag = digest(json)
      return [304, {}, []] if env['HTTP_IF_NONE_MATCH'] == etag
      [
        200,
        {
          'Content-Type' => 'application/json',
          'Etag' => etag,
          'Content-Length' => json.length.to_s
        },
        [json]
      ]
    else
      @app.call(env)
    end
  end

  private
  def digest(str)
    Digest::MD5.hexdigest(str)
  end
end

