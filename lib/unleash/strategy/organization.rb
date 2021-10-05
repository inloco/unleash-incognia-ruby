module Unleash
  module Strategy
    class Organization < Base
      PARAM = 'organizationIds'.freeze

      def name
        'Organization'
      end

      # requires: params['organizationIds'], context.properties.organization_id,
      def is_enabled?(params = {}, context = nil)
        return false unless params.is_a?(Hash) && params.key?(PARAM)
        return false unless params.fetch(PARAM, nil).is_a? String
        return false unless context.class.name == 'Unleash::Context'
        return false unless context.properties.fetch(:organization_id, nil)

        organization_id = context.properties.fetch(:organization_id)

        params[PARAM]
          .split(',')
          .map(&:strip)
          .include?(organization_id.to_s)
      end
    end
  end
end
