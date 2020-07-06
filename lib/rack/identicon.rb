require "rack/identicon/version"
require "rack/identicon/caching"
require "digest"
require "identicon"

module Rack
  module Identicon
    class Error < StandardError; end

    include Caching

    DEFAULT_SIZE = 128
    DEFAULT_BG   = "ffffff".freeze

    def self.new *args
      Middleware.new *args
    end

    class Middleware
      def call env
        request = Rack::Request.new env
        [ 200, { "Content-Type" => "image/png" }, [ response_body(request) ] ]
      end

      protected

        def response_body request
          Rack::Identicon.cache cache_key(request) do
            data = extract_payload request
            size = extract_size request
            bg   = extract_background request

            ::Identicon.blob_for(data, size.to_i, bg)
          end
        end

        def extract_payload request
          Digest::SHA2.hexdigest request.path_info[1..-1]
        end

        def extract_size request
          request.params["s"] || DEFAULT_SIZE
        end

        def extract_background request
          color = request.params.fetch "b", DEFAULT_BG
          color.scan(/.{2}/).map { |c| c.to_i 16 }
        end

        def cache_key request
          Digest::SHA2.hexdigest request.path_info + request.query_string
        end
    end
  end
end

require "rack/identicon/railtie" if defined? ::Rails
