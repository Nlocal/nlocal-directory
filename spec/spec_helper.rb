require 'bundler/setup'
Bundler.setup

require 'nlocal/directory' # and any other gems you need
require 'factory_girl'
require 'her'
require 'vcr'
require 'dotenv'
require 'byebug'
Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  # some (optional) config here
  config.include FactoryGirl::Syntax::Methods
  config.extend VCR::RSpec::Macros

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

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

def test_user
  RequestStore.store[:user] ||= ENV['API_EMAIL']
end

def test_password
  RequestStore.store[:password] ||= ENV['API_PASSWORD']
end
