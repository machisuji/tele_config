require 'uri-open'

module TeleConfig
  module Sources
    class URI < TeleConfig::Source
      param :uri

      def read
        open(uri) { |f| f.read }
      end
    end
  end
end
