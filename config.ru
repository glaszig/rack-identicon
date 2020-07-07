require "rack/identicon"

HTML = <<MARKUP
<html>
<body>
<img src="/__identicon__/foo">
</body>
</html>
MARKUP

map("/__identicon__") { run Rack::Identicon.new }
map("/sample") { run proc { [200, {'Content-Type' => "text/html"}, [HTML]]} }
run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK']] }
