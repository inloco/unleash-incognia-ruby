RSpec.describe Unleash::Incognia do
  it 'has a version number' do
    expect(Unleash::Incognia::VERSION).not_to be nil
  end

  describe '.configuration' do
    subject(:configuration) { described_class.configuration }

    it 'returns a Configuration' do
      expect(configuration).to be_a(Unleash::Incognia::Configuration)
    end
  end

  describe '.configure' do
    it 'yields with current configuration' do
      expect { |b| described_class.configure(&b) }.
        to yield_with_args(Unleash::Incognia::Configuration)

      expect { |b| described_class.configure(&b) }.
        to yield_with_args(described_class.configuration)
    end
  end
end
