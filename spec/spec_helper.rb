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
  c.default_cassette_options = { record: :new_episodes,
                                 erb: true,
                                 match_requests_on: [:uri, :body, :method]
                               }

  c.filter_sensitive_data('<PASSWORD>') do |interaction|
    CGI.escape(test_password)
  end
  c.filter_sensitive_data('<USER>') do |interaction|
    CGI.escape(test_user)
  end
  c.filter_sensitive_data('<DUMMY_TOKEN>') do |interaction|
    CGI.escape(RequestStore.store[:token].access_token) if RequestStore.store[:token]
  end
  c.filter_sensitive_data('<DUMMY_TOKEN>') do |interaction|
    token_matches= /"access_token":"(?<token>.+)",/.match(interaction.response.body)
    token_matches ? token_matches[:token] : nil
  end
end

RSpec.configure do |config|
  # some (optional) config here
  config.include FactoryGirl::Syntax::Methods
  config.extend VCR::RSpec::Macros

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end


def test_user
  RequestStore.store[:user] ||= ENV['API_EMAIL']
end

def test_password
  RequestStore.store[:password] ||= ENV['API_PASSWORD']
end
