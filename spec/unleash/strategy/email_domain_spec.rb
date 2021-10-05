require 'spec_helper'

RSpec.describe Unleash::Strategy::EmailDomain do
  describe 'is_enabled?' do
    subject(:is_enabled?) { described_class.new.is_enabled?(params, context) }
    let(:context) do
      Unleash::Context.new(
        properties: { user_email: 'rafael.albuquerque@inloco.com.br' }
      )
    end
    let(:params) { { 'emailDomains' => 'inloco.com.br,inloco.com' } }

    context 'when params is invalid' do
      let(:expected_result) { false }

      context 'because it is a string' do
        let(:params) { 'invalid' }

        it 'returns false' do
          expect(is_enabled?).to be false
        end
      end

      context 'because it is a integer' do
        let(:params) { 10 }

        it 'returns false' do
          expect(is_enabled?).to be false
        end
      end

      context 'because it is a empty hash' do
        let(:params) { {} }

        it 'returns false' do
          expect(is_enabled?).to be false
        end
      end

      context 'because it is a hash without expected key' do
        let(:params) { { b: 'without key' } }

        it 'returns false' do
          expect(is_enabled?).to be false
        end
      end

      context 'because it is a hash with invalid values' do
        let(:params) { { memberIds: ['should', 'be', 'a', 'String'] } }

        it 'returns false' do
          expect(is_enabled?).to be false
        end
      end
    end

    context 'when context is invalid' do
      let(:expected_result) { false }

      context 'because it is a empty hash' do
        let(:context) { {} }

        it 'returns false' do
          expect(is_enabled?).to be false
        end
      end

      context 'because it is empty' do
        let(:context) { Unleash::Context.new(properties: {}) }

        it 'returns false' do
          expect(is_enabled?).to be false
        end
      end
    end

    context 'when context and params is valid' do
      it 'returns true' do
        expect(is_enabled?).to be true
      end

      context 'when user email domain is not included in params' do
        let(:context) do
          Unleash::Context.new(
            properties: { user_email: 'rafael.albuquerque@inlocomedia.com' }
          )
        end

        it 'returns false' do
          expect(is_enabled?).to be false
        end
      end
    end
  end
end
