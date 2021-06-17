module Colorly
  class Script
    attr_reader :script, :filename

    def self.load(script_file)
      raise ScriptNotFound, "Unable to load #{script_file}" unless File.exist? script_file
      new File.read(script_file), filename: script_file
    end

    def initialize(script, filename: nil)
      @script, @filename = script, filename
    end

    def run
      instance_eval script
    end

    def output
      @output ||= {}
    end

    def to_h
      output.transform_values do |chroma_array|
        chroma_array.map do |chroma|
          chroma.to_hex
        end
      end
    end

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

    def current_title
      @current_title ||= "Untitled"
    end

  end
end
