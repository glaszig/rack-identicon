$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "rack/identicon"
require "rack/test"
require "pry"

require "minitest/autorun"
