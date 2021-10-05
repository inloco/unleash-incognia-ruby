module Unleash
  module Strategy
    class Member < Base
      PARAM = 'memberIds'.freeze

      def name
        'Member'
      end

      # requires: params['memberIds'], context.properties.organization_id,
      # context.properties.user_id
      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.class.name == 'Unleash::Context'
        return false unless context.properties.fetch(:user_id, nil)
        return false unless context.properties.fetch(:organization_id, nil)

        user_id = context.properties.fetch(:user_id)
        organization_id = context.properties.fetch(:organization_id)
        member_id = "#{user_id}##{organization_id}"

        params[PARAM]
          .split(',')
          .map(&:strip)
          .include?(member_id)
      end
    end
  end
end
