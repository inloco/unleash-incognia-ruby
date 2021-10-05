module Unleash
  module Strategy
    class EmailDomain < Base
      PARAM = 'emailDomains'.freeze

      def name
        'EmailDomain'
      end

      # requires: params['emailDomains'], context.properties.user_email,
      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.class.name == 'Unleash::Context'
        return false unless context.properties.fetch(:user_email, nil)

        user_email = context.properties.fetch(:user_email)
        user_email_domain = user_email.split('@').last

        params[PARAM]
          .split(',')
          .map(&:strip)
          .include?(user_email_domain)
      end
    end
  end
end
