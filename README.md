# Rack::Manifest

This is a Rack middleware for managing your HTML5 manifest file (used for Service Worker, WebApp Icon, etc.) by yaml.
It can be easily implemented into your Rails application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-manifest'
```

## Usage

### Rails
* Set `manifest.yml` file like this one into your `config` directory.
* After restarting server, you can see the converted manifest file on `/manifest.json` path.
* ERB format and asset path helpers are available.

```yaml
name: Rack Manifest
short_name: Manifest
icons: 
  - src: <%= image_path('icon.png') %>
    sizes: 512x512
    type: image/png
start_url: /
display: standalone
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

