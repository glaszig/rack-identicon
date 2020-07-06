require "rack/identicon"

map("/__identicon__") { run Rack::Identicon.new }
run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK']] }
