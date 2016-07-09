require 'json'
require 'erb'
require 'action_view/helpers/asset_url_helper'
require 'rack/request'
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
      headers = {}
      if env.has_key?('HTTP_IF_MODIFIED_SINCE')
        fetched_date = env['HTTP_IF_MODIFIED_SINCE']
        return [304, headers, []] if get_modified_time(FILE_PATH) == fetched_date
      end
      manifest = load_yaml(FILE_PATH)
      json = JSON.generate(manifest)
      [
        200,
        headers.merge({
          'Content-Type' => 'application/json',
          'Last-Modified' => get_modified_time(FILE_PATH),
          'Content-Length' => json.length.to_s
        }),
        [json]
      ]
    else
      @app.call(env)
    end
  end

  private
  def get_modified_time(path)
    time = File.mtime(path)
    time.strftime('%a, %d %b %Y %H:%M:%S GMT')
  end
end

