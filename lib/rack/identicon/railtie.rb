module Rack
  module Identicon
    class Railtie < Rails::Railtie
      initializer "rack_identicon.caching" do |app|
        Rack::Identicon.cache_store = Rails.cache
      end
    end
  end
end
