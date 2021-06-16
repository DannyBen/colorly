require 'spec_helper'

describe Script do
  subject { described_class.new script }
  let(:script) { "title 'Hello' ; add 'red' ; add last.spin 180" }

  describe '::load' do
    subject { described_class.load script_file }
    let(:script_file) { 'spec/fixtures/basic_script.rb' }
    let(:script_file_content) { File.read script_file }

    it "returns a Script instance" do
      expect(subject).to be_a Script
    end

    it "loads the script into the instance" do
      expect(subject.script).to eq script_file_content
    end

    it "sets the filename attribute" do
      expect(subject.filename).to eq script_file
    end
  end

  describe '#run' do
    it "evaluates the script and populates the output hash" do
      subject.run
      matter = subject.output

      expect(matter).to be_a Hash
      expect(matter["Hello"]).to be_an Array
      expect(matter["Hello"].count).to eq 2
      expect(matter["Hello"].first).to be_a Chroma::Color
    end
  end

  describe '#to_h' do
    it "returns a clean hash with colors and titles" do
      subject.run
      expect(subject.to_h).to eq("Hello" => ["#ff0000", "#00ffff"])
    end

    context "with more than one sets" do
      let(:script) { "title 'One' ; add 'red' ; title 'Two' ; add 'blue' "}

      it "returns all sets" do
        subject.run
        expect(subject.to_h).to eq("One" => ["#ff0000"], "Two" => ["#0000ff"])
      end
    end
  end

  describe '#add' do
    it "adds a new color to the current color set" do
      subject.title "Preroll"
      subject.add "yellow"
      subject.run
      expect(subject.output["Preroll"].first.name).to eq "Yellow"
    end
  end

  describe '#last' do
    it "returns the last added color" do
      subject.run
      expect(subject.last.name).to eq "Aqua"
    end
  end

  describe '#random' do
    it "returns a random color" do
      expect(subject.random[0]).to eq '#'
      expect(subject.random.size).to eq 7
    end
  end
end
