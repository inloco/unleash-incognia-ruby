require 'spec_helper'

RSpec.describe Unleash::Incognia::Client do
  subject(:client) do
    described_class.new(user: user, organization: organization)
  end
  let(:user) { double('User', id: rand, email: 'myemail@mail.com') }
  let(:organization) { double('Organization', id: rand) }

  before do
    Unleash::Incognia.configure do |config|
      config.unleash_client = unleash_client
    end
  end
  let(:unleash_client) { instance_double(Unleash::Client) }

  describe '#feature_enabled?' do
    subject(:feature_enabled?) { client.feature_enabled?(feature_name) }
    let(:feature_name) { 'my_feature_name' }

    it 'invokes unleash client with proper context' do
      expected_properties = {
        user_id: user.id,
        user_email: user.email,
        organization_id: organization.id
      }

      expect(unleash_client).to receive(:is_enabled?) do |name, context|
        expect(name).to eq(feature_name)
        expect(context).to be_a(Unleash::Context)
        expect(context.properties).to eq(expected_properties)
      end

      feature_enabled?
    end

    context 'when organization was not informed' do
      let(:organization) { nil }

      it 'invokes unleash client with proper context' do
        expected_properties = {
          user_id: user.id,
          user_email: user.email
        }

        expect(unleash_client).to receive(:is_enabled?) do |name, context|
          expect(name).to eq(feature_name)
          expect(context).to be_a(Unleash::Context)
          expect(context.properties).to eq(expected_properties)
        end

        feature_enabled?
      end
    end
  end

  describe '#enabled_features' do
    subject(:enabled_features) { client.enabled_features }

    before do
      allow(Unleash).to receive(:toggles).and_return(all)

      enabled.each do |feature_flag_name|
        allow(unleash_client).to receive(:is_enabled?).
          with(feature_flag_name, anything).
          and_return(true)
      end

      disabled.each do |feature_flag_name|
        allow(unleash_client).to receive(:is_enabled?).
          with(feature_flag_name, anything).
          and_return(false)
      end
    end
    let(:all) do
      (enabled + disabled).map { |name| { 'name' => name } }
    end
    let(:enabled) { ['FEATURE1', 'FEATURE2', 'FEATURE3'] }
    let(:disabled) { ['FEATURE4', 'FEATURE5', 'FEATURE6'] }

    it 'returns all enabled feature flags' do
      expect(enabled_features).to eq(enabled)
    end
  end
end
