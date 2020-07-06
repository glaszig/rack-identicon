module Rack
  module Identicon
    module Caching

      def self.included base
        base.extend ClassMethods
        base.cache_store = NullCacheStore.new
      end

      class NullCacheStore
        def exist? key
          false
        end

        def read key
        end

        def write key, data
        end

        def fetch key
          yield
        end
      end

      module ClassMethods
        attr_accessor :cache_store

        def cache key, &blk
          cache_store.fetch key, &blk
        end
      end

    end
  end
end
