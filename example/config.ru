require 'rack/manifest'

use Rack::Manifest

run Proc.new {|env|
  [
    200, 
    {'Content-Type' => 'text/plain'}, 
    ['Open /manifest.json to show sample manifest file.']
  ] 
}

