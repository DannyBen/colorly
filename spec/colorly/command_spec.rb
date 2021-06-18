require 'spec_helper'

describe Command do
  subject { CLI.router }
  let(:script_path) { 'spec/fixtures/basic_script.rb' }

  before { reset_tmp_dir }

  it "executes a script and outputs to stdout" do
    expect { subject.run %W[ #{script_path} ] }.to output_approval('cli/basic')
  end

  context "with --names", :focus do
    it "also outputs color names" do
      expect { subject.run %W[ #{script_path} --names ] }.to output_approval('cli/basic-names')
    end
  end

  context "with an output path that ends with .json" do
    let(:out) { 'spec/tmp/out.json' }
    
    it "saves a JSON output" do
      expect(File).not_to exist(out)
      expect { subject.run %W[ #{script_path} #{out} ] }.to output_approval('cli/json')
      expect(File).to exist(out)      
      expect(File.read out).to match_approval('cli/json-content')
    end
  end

  context "with an output path that ends with .yaml" do
    let(:out) { 'spec/tmp/out.yaml' }
    
    it "saves a YAML output" do
      expect(File).not_to exist(out)
      expect { subject.run %W[ #{script_path} #{out} ] }.to output_approval('cli/yaml')
      expect(File).to exist(out)      
      expect(File.read out).to match_approval('cli/yaml-content')
    end
  end

  context "with an output path that ends with .html" do
    let(:out) { 'spec/tmp/out.html' }
    
    it "saves an HTML output" do
      expect(File).not_to exist(out)
      expect { subject.run %W[ #{script_path} #{out} ] }.to output_approval('cli/html')
      expect(File).to exist(out)      
      expect(File.read out).to match_approval('cli/html-content')
    end

    context "with --names" do
      it "also renders color names in the HTML" do
        expect(File).not_to exist(out)
        expect { subject.run %W[ #{script_path} #{out} --names ] }.to output_approval('cli/html-names')
        expect(File).to exist(out)      
        expect(File.read out).to match_approval('cli/html-names-content')
      end
    end

  end

  context "with an output path that ends with an unknown extension" do
    let(:out) { 'spec/tmp/out.pdf' }
    
    it "raises an error" do
      expect { subject.run %W[ #{script_path} #{out} ] }.to raise_approval('cli/unknown-extension')
    end
  end

  context "with --watch" do
    it "generates immediately and on change" do
      expect do
        expect_any_instance_of(Filewatcher).to receive(:watch) do |watcher, &block|
          block.call
        end

        subject.run %W[ #{script_path} --watch ]
      end.to output_approval('cli/watch')
    end
  end

end
