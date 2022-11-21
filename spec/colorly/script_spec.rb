require 'spec_helper'

describe Script do
  subject { described_class.new script }

  let(:script) { "title 'Hello' ; add 'red' ; add last.spin 180" }

  describe '::load' do
    subject { described_class.load script_file }

    let(:script_file) { 'spec/fixtures/basic_script.rb' }
    let(:script_file_content) { File.read script_file }

    it 'returns a Script instance' do
      expect(subject).to be_a described_class
    end

    it 'loads the script into the instance' do
      expect(subject.script).to eq script_file_content
    end

    it 'sets the filename attribute' do
      expect(subject.filename).to eq script_file
    end

    context 'when the file is not found' do
      let(:script_file) { 'not-found.rb' }

      it 'raises an error' do
        expect { subject }.to raise_error Colorly::ScriptNotFound
      end
    end
  end

  describe '#run' do
    it 'evaluates the script and populates the output hash' do
      subject.run
      output = subject.output

      expect(output.to_s).to eq '{"Hello"=>[red, cyan]}'
      expect(output['Hello'].first).to be_a Chroma::Color
    end

    context 'when the script contains errors' do
      subject { described_class.load script_file }

      let(:script_file) { 'spec/fixtures/broken_script.rb' }

      it 'raises a ScriptError' do
        expect { subject.run }.to raise_approval('script/error')
      end
    end

    context 'when the script contains syntax errors' do
      subject { described_class.load script_file }

      let(:script_file) { 'spec/fixtures/broken_script2.rb' }

      it 'raises a ScriptSyntaxError' do
        expect { subject.run }.to raise_error(ScriptSyntaxError)
      end
    end
  end

  describe '#simple_output' do
    it 'returns a clean hash with colors and titles' do
      subject.run
      expect(subject.simple_output).to eq('Hello' => ['#ff0000', '#00ffff'])
    end

    context 'with names: true' do
      it 'also adds color names to the returned hash' do
        subject.run
        expect(subject.simple_output names: true)
          .to eq('Hello' => [{ hex: '#ff0000', name: %w[Red Red] }, { hex: '#00ffff', name: %w[Aqua Blue] }])
      end
    end

    context 'with more than one sets' do
      let(:script) { "title 'One' ; add 'red' ; title 'Two' ; add 'blue' " }

      it 'returns all sets' do
        subject.run
        expect(subject.simple_output).to eq('One' => ['#ff0000'], 'Two' => ['#0000ff'])
      end
    end
  end

  describe '#params' do
    let(:script) { 'add params[:base] ; add last.spin 180' }

    before { subject.params[:base] = '#CDC' }

    it 'provides a mechanism to pass context variables to the script' do
      subject.run
      matter = subject.simple_output

      expect(matter['Colors']).to eq ['#ccddcc', '#ddccdd']
    end
  end

  describe '#to_h' do
    it 'returns the same output as simple_output without names' do
      subject.run
      expect(subject.to_h).to eq(subject.simple_output)
    end
  end

  describe '#add' do
    before do
      subject.title 'Test'
      subject.add color
      subject.run
    end

    let(:color) { 'yellow' }

    it 'adds a new color to the current color set' do
      expect(subject.output['Test'].first.name).to eq 'Yellow'
    end

    context 'when color is a Chroma::Color' do
      let(:color) { 'blue'.paint }

      it 'adds it to the current color set' do
        expect(subject.output['Test'].first.name).to eq 'Blue'
      end
    end

    context 'when color is an Array' do
      let(:color) { ['green', 'red'.paint] }

      it 'adds all colors the current color set' do
        expect(subject.output['Test'].first.name).to eq 'Green'
        expect(subject.output['Test'].last.name).to eq 'Red'
      end
    end
  end

  describe '#last' do
    it 'returns the last added color' do
      subject.run
      expect(subject.last.name).to eq 'Aqua'
    end
  end

  describe '#random' do
    it 'returns a random color' do
      expect(subject.random[0]).to eq '#'
      expect(subject.random.size).to eq 7
    end
  end
end
