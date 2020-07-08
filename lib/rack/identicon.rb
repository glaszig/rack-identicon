require "rack/identicon/version"
require "rack/identicon/caching"
require "rack/identicon/response"

module Rack
  module Identicon
    class Error < StandardError; end

    include Caching

    def self.new *args
      proc { |env| Response.new(env).triplet }
    end
  end
end

require "rack/identicon/railtie" if defined? ::Rails
