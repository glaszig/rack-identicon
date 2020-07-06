require "test_helper"

class Rack::IdenticonTest < Minitest::Test
  include Rack::Test::Methods

  def app
    @app ||= Rack::Builder.app do
      map("/__identicon__") { run Rack::Identicon.new }
      run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK']] }
    end
  end

  def test_response_is_ok
    get '/'
    assert last_response.ok?
    assert_equal last_response.body, "OK"
  end

  def test_get_identicon
    get '/__identicon__/foobar'
    assert last_response.ok?

    assert_equal File.binread("test/fixtures/identicon.png"), last_response.body
  end

  def test_not_found
    get '/__identicon__/'
    assert last_response.not_found?
    assert_equal last_response.body, "Not Found"
  end
end
