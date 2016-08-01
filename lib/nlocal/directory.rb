require 'her'
require 'request_store'
require_relative './directory/configuration'
require_relative './directory/version'

module Nlocal
  module Directory
    class << self
      attr_accessor :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end

  end
end

Dir[File.expand_path("../directory/**/*.rb", __FILE__)].each{ |f| require f}
