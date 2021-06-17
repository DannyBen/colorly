require 'spec_helper'

describe Chroma::Color do
  subject { 'blue'.paint.darken(20) }

  describe '#name' do
    it "returns the color's name" do
      expect(subject.name).to eq "New Midnight Blue"
    end
  end

  describe '#shade' do
    it "returns the color's shade" do
      expect(subject.shade).to eq "Blue"
    end
  end
end
