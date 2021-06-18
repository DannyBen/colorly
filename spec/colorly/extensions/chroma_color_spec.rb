require 'spec_helper'

describe Chroma::Color do
  subject { 'blue'.paint.darken(20) }
  let(:colors) do
    script = Script.new "180.times { add last.spin 2 }"
    script.run
    script.output["Untitled"].map { |c| "#{c.to_hex} : #{c.shade} : #{c.name}" }
  end

  it "properly identifies color names and shades", :slow do
    expect(colors.to_yaml).to match_approval('color-names')
  end

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
