require 'spec_helper'

describe StringRefinements do
  using StringRefinements
  subject { 'red' }

  describe '#spin' do
    it "returns Chroma::Color" do
      expect(subject.spin 10).to be_a Chroma::Color
    end
  end

  describe '#darken' do
    it "returns Chroma::Color" do
      expect(subject.darken 10).to be_a Chroma::Color
    end
  end

  describe '#lighten' do
    it "returns Chroma::Color" do
      expect(subject.lighten 10).to be_a Chroma::Color
    end
  end

  describe '#saturate' do
    it "returns Chroma::Color" do
      expect(subject.saturate 10).to be_a Chroma::Color
    end
  end

  describe '#desaturate' do
    it "returns Chroma::Color" do
      expect(subject.desaturate 10).to be_a Chroma::Color
    end
  end

  describe '#palette' do
    it "returns Chroma::Harmonies" do
      expect(subject.palette).to be_a Chroma::Harmonies
    end
  end

end
