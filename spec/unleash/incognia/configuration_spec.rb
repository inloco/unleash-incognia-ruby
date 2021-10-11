require 'spec_helper'

RSpec.describe Unleash::Incognia::Configuration do
  subject(:configuration) do
    described_class.new(unleash_client: client)
  end
  let(:client) { instance_double(Unleash::Client) }

  describe '#unleash_client' do
    it 'respond to unleash_client' do
      expect(configuration.unleash_client).to eq(client)
    end
  end
end
