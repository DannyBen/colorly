module Colorly
  class Script
    using StringRefinements
    attr_reader :script, :filename

    def self.load(script_file)
      raise ScriptNotFound, "Unable to load #{script_file}" unless File.exist? script_file
      new File.read(script_file), filename: script_file
    end

    def initialize(script, filename: nil)
      @script, @filename = script, filename
    end

    def run
      run!
    rescue SyntaxError => e
      raise ScriptSyntaxError.new e
    rescue => e
      raise ScriptError.new e
    end

    def output
      @output ||= {}
    end

    def simple_output(names: false)
      output.transform_values do |chroma_array|
        chroma_array.map do |chroma|
          if names
            { hex: chroma.to_hex, name: [chroma.name, chroma.shade] }
          else
            chroma.to_hex
          end
        end
      end
    end
    alias to_h simple_output

    # DSL Methods

    def title(title)
      @current_title = title
    end

    def add(color)      
      if color.is_a? Array
        color.each { |c| add c }
      else
        output[current_title] ||= []
        register color
        output[current_title] << last
      end
    end

    def register(color)
      @last = color.is_a?(String) ? color.paint : color
    end

    def last
      @last ||= 'red'.paint
    end

    def random
      "#%06x" % (rand * 0xffffff)
    end

  private

    def run!
      if filename
        instance_eval script, filename
      else
        instance_eval script
      end
    end

    def current_title
      @current_title ||= "Untitled"
    end

  end
end
