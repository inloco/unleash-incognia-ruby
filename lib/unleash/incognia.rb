require_relative 'incognia/version'

require 'unleash/strategy/base'
require 'unleash/strategy/member'
require 'unleash/strategy/email_domain'
require 'unleash/strategy/organization'

require 'unleash/incognia/configuration'
require 'unleash/incognia/client'

module Unleash
  module Incognia
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end
    end
  end
end
