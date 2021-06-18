require "colsole"
require "mister_bin"
require 'erb'
require 'filewatcher'
require 'json'
require 'ostruct'
require 'yaml'

module Colorly
  class Command < MisterBin::Command
    include Colsole
    summary "Run a colorly script"

    help "Execute a colorly script and save or print its output"

    usage "colorly SCRIPT [OUTPUT_PATH] [--watch --names]"
    usage "colorly --help"

    option "-w, --watch", "Watch the script file and regenerate on change"
    option "-n, --names", "Also show color names and shades (slower)"

    param "SCRIPT", "Path to script file"
    param "OUTPUT_PATH", "Path to output file. The output format is determined by the file extension. Supported formats:\n- YAML (.yaml or .yml)\n- JSON (.json)\n- HTML (.html)\nIf left empty, YAML format will be sent to STDOUT."

    example "colorly examples/example.rb"
    example "colorly examples/example.rb --names"
    example "colorly examples/example.rb out.json"
    example "colorly examples/example.rb out.html --watch --names"

    attr_reader :script_path, :script, :out_path, :use_names

    def run
      @script_path = args['SCRIPT']
      @out_path = args['OUTPUT_PATH']
      @use_names = args['--names']

      if args['--watch']
        watch_and_generate
      else
        generate
      end
    end

  private

    def watch_and_generate
      say "Watching !txtpur!#{script_path}"
      Filewatcher.new(script_path).watch do
        generate
      end
    end

    def generate
      @script = Script.load script_path
      script.run

      out_path ? save_file : show_output
    end

    def show_output
      puts simple_output.to_yaml
    end

    def simple_output
      script.simple_output names: use_names
    end

    def save_file
      out_string = case out_path
      when /\.json$/
        JSON.pretty_generate simple_output
      when /\.ya?ml$/
        simple_output.to_yaml
      when /\.html$/
        erb html_template, { output: script.output, use_names: use_names }
      else
        raise Colorly::ArgumentError, "Unknown output format for #{out_path}"
      end
      
      File.write out_path, out_string
      say "Saved !txtpur!#{out_path}"
    end

    def html_template
      File.read html_template_file
    end

    def html_template_file
      File.expand_path "templates/html.erb", __dir__
    end

    def erb(template, vars)
      # TODO: This new format is only supported in Ruby >= 2.6
      #       So for now, we keep the old deprecated syntax
      # ERB.new(template, trim_mode: '%-').result(binding)
      ERB.new(template, nil, '%-').result(OpenStruct.new(vars).instance_eval { binding })
    end
  end
end
