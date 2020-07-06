require "digest"
require "identicon"

module Rack
  module Identicon
    class Response
      DEFAULT_SIZE = 128
      DEFAULT_BG   = "ffffff".freeze

      def initialize env
        @request = Rack::Request.new env
        @size = @request.params["s"] || DEFAULT_SIZE
        @bg = parse_color @request.params.fetch "b", DEFAULT_BG
      end

      def body
        cache { ::Identicon.blob_for hashed_payload, @size.to_i, @bg }
      end

      def triplet
        if valid_request?
          [ 200, { "Content-Type" => "image/png" }, [ body ] ]
        else
          [ 404, { "Content-Type" => "text/plain" }, [ "Not Found" ] ]
        end
      end

      protected

        def valid_request?
          payload.length > 0
        end

        def hashed_payload
          @hashed_payload ||= Digest::SHA2.hexdigest(payload)
        end

        def payload
          @payload ||= @request.path_info[1..-1].to_s.strip
        end

        def parse_color hex_str
          hex_str.scan(/.{2}/).map { |c| c.to_i 16 }
        end

        def cache &blk
          Rack::Identicon.cache cache_key, &blk
        end

        def cache_key
          hashed_payload + "?s=#{@size}&b=#{@bg}"
        end
    end
  end
end
