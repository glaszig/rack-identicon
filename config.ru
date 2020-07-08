require "rack/identicon"

map("/__identicon__") { run Rack::Identicon.new }
map("/sample") do
  response = [
    200,
    { 'Content-Type' => 'text/html' },
    [ '<html><body><img src="/__identicon__/foo"></body></html>' ]
  ]
  run proc { response }
end
run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK']] }
