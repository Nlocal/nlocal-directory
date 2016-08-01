require_relative './middleware/authentication'
require_relative './middleware/oauth'

module Nlocal
  module Directory
    class Configuration
      attr_accessor :access_key, :secret_key, :personal_key, :host, :version, :vendor

      def initialize
        @access_key = nil
        @secret_key = nil
        @personal_key = nil
        @host= "devbox:3000"
        @vendor = "nlocal"
        @version = "v1"
        api_init
        oauth_init
      end

      def api_init (api_host=host, &block)
        @api = Her::API.new

        @api.setup :url => "http://#{api_host}/api/" do |c|
          # Request
          c.use Nlocal::Directory::Middleware::Authentication
          c.use Faraday::Request::UrlEncoded

          # Response
          c.use Her::Middleware::DefaultParseJSON

          # Adapter
          c.use Faraday::Adapter::NetHttp

          # allow for customizing faraday connection
          yield c if block_given?

          # inject default adapter unless in test mode
          # c.adapter Faraday.default_adapter unless c.builder.handlers.include?(Faraday::Adapter::Test)
        end
      end

      def oauth_init (api_host=host, &block)
        @oauth = Her::API.new

        @oauth.setup :url => "http://#{api_host}/oauth" do |c|
          # Request
          c.use Nlocal::Directory::Middleware::Oauth
          c.use Faraday::Request::UrlEncoded

          # Response
          c.use Her::Middleware::DefaultParseJSON

          # Adapter
          c.use Faraday::Adapter::NetHttp

          # allow for customizing faraday connection
          yield c if block_given?

          # inject default adapter unless in test mode
          # c.adapter Faraday.default_adapter unless c.builder.handlers.include?(Faraday::Adapter::Test)
        end
      end

      def api
       # raise exception if somehow model classes gets required
       # before the API is configured
        raise ClientNotConfigured.new("Nlocal-Api") unless @api
        @api
      end

      def oauth
        # raise exception if somehow model classes gets required
        # before the API is configured
         raise ClientNotConfigured.new("Nlocal-Oauth") unless @oauth
         @oauth
      end

      class ClientNotConfigured < Exception; end

    end
  end
end
