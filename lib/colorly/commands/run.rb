module Colorly
  module Commands
    class RunCmd < Base
      include Colorly::DSL

      summary "Run a colrly script"

      # help "This command sends a request to the provided API endpoint. The currently configured network is automatically prepended to the endpoint path, and the output is converted to YAML format."

      usage "colorly run SCRIPT [--watch]"
      usage "colorly run --help"

      option "-w, --watch", "Watch the script file and regenerate on change"

      param "SCRIPT", "Path to script file"

      example "colorly run examples/sample.rb"

      def run
        script = args['SCRIPT']

        if args['--watch']
          run! %Q[filewatcher --immediate "#{script}" "run '#{script}'"]
        elsif File.exist? script
          reset
          instance_eval(File.read script)
          save unless saved?
        else
          raise ScriptNotFound, "Unable to load '#{script}'"
        end
      end

    end
  end
end