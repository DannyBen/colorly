require 'spec_helper'

describe CLI do
  describe '::router' do
    subject { described_class.router }

    it 'returns a MisterBin::Runner instance' do
      expect(subject).to be_a MisterBin::Runner
    end

    it 'executes properly' do
      expect { subject.run }.to output_approval('cli/usage')
    end
  end
end
