module Unleash
  module Incognia
    class Client
      def initialize(user:, organization: nil)
        @user = user
        @organization = organization
      end

      def feature_enabled?(name)
        client.is_enabled? name, context
      end

      def enabled_features
        feature_flags_names = Unleash.toggles.map do |feature_flag|
          feature_flag['name']
        end

        feature_flags_names.select { |name| feature_enabled?(name) }
      end

      private

      attr_reader :user, :organization

      def client
        Incognia.configuration.unleash_client
      end

      def context
        @context ||= Unleash::Context.new(
          properties: {
            user_id: user.id,
            user_email: user.email,
            organization_id: organization&.id
          }.compact
        )
      end
    end
  end
end
