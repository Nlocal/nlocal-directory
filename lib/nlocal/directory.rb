require "nlocal/directory/version"
require 'nlocal/directory/configuration'

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
