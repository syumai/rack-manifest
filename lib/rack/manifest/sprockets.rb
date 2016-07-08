require 'sprockets/cache'
require 'sprockets/erb_processor'

module Rack::Manifest::Sprockets
  def load_yaml path
    input = {
      environment: Rails.application.assets,
      filename: 'manifest.yml.erb',
      content_type: 'text/yaml',
      data: File.read(FILE_PATH),
      metadata: {},
      cache: Sprockets::Cache.new
    }
    result = Sprockets::ERBProcessor.call(input)
    YAML.load(result[:data])
  end
end
