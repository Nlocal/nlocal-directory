require 'bundler/setup'
Bundler.setup

require 'your_gem_name' # and any other gems you need

RSpec.configure do |config|
  # some (optional) config here
  config.include(Module.new do
   def stub_api_for(klass)
     klass.use_api (api = Her::API.new)

     # Here, you would customize this for your own API (URL, middleware, etc)
     # like you have done in your application’s initializer
     api.setup url: "http://api.example.com" do |c|
       # Request
       c.use Nlocal::Directory::Middleware::Authentication
       c.use Faraday::Request::UrlEncoded

       # Response
       c.use Her::Middleware::DefaultParseJSON

       # Adapter
       c.use Faraday::Adapter::NetHttp::FirstLevelParseJSON
       c.adapter(:test) { |s| yield(s) }
     end
   end

   def stub_oauth_for(klass)
     klass.use_api (api = Her::API.new)

     # Here, you would customize this for your own API (URL, middleware, etc)
     # like you have done in your application’s initializer
     api.setup url: "http://api.example.com" do |c|
       # Request
       c.use Nlocal::Directory::Middleware::Oauth
       c.use Faraday::Request::UrlEncoded

       # Response
       c.use Her::Middleware::DefaultParseJSON

       # Adapter
       c.use Faraday::Adapter::NetHttp
       c.adapter(:test) { |s| yield(s) }
     end
   end

  end)
end
