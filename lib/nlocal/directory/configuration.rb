module Nlocal
  module Directory
    class Configuration
      attr_accessor :access_key, :secret_key, :personal_key

      mattr_accessor :her_default_opts
      @@her_default_opts = {url: "http://devbox:3000"}

      mattr_accessor :her_default_opts
      @@her_default_block = {|c|

       # Request
       c.use Nlocal::Directory::Middleware::TokenAuthentication
       c.use Faraday::Request::UrlEncoded

       # Response
       c.use Her::Middleware::DefaultParseJSON

       # Adapter
       c.use Faraday::Adapter::NetHttp
      }

      def initialize
        @access_key = nil
        @secret_key = nil
        @personal_key = nil
        her_init
      end

      def her_init (opts= her_default_opts, &block = her_default_block)
        Her::API.setup opts &block
      end

    end
  end
end
