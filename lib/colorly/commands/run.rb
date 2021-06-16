require 'json'
require 'yaml'
require 'erb'
require 'ostruct'

module Colorly
  module Commands
    class RunCmd < Base
      summary "Run a colorly script"

      help "Execute a colorly script and save or print its output"

      usage "colorly run SCRIPT [OUTPUT_PATH] [--watch]"
      usage "colorly run --help"

      option "-w, --watch", "Watch the script file and regenerate on change"

      param "SCRIPT", "Path to script file"
      param "OUTPUT_PATH", "Path to output file. The output format is determined by the file extension. Supported formats:\n- YAML (.yaml or .yml)\n- JSON (.json)\n- HTML (.html)\nIf left empty, YAML format will be sent to STDOUT."

      example "colorly run examples/sample.rb"
      example "colorly run examples/sample.rb out.json"
      example "colorly run examples/sample.rb out.html --watch"

      attr_reader :script, :out_path

      def run
        script = args['SCRIPT']
        @out_path = args['OUTPUT_PATH']

        if args['--watch']
          run! %Q[filewatcher --immediate "#{script}" "run '#{script}'"]
        else
          @script = Script.load script
          generate_output
        end
      end

    private

      def generate_output
        script.run

        if out_path
          save_file
        else
          puts script.to_h.to_yaml
        end
      end

      def save_file
        out_string = case out_path
        when /\.json$/
          JSON.pretty_generate script.to_h
        when /\.ya?ml$/
          script.to_h.to_yaml
        when /\.html$/
          erb html_template, { output: script.output }
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
        File.expand_path "../templates/html.erb", __dir__
      end

      def erb(template, vars)
        ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
      end

    end
  end
end
