module Colorly
  class Error < StandardError; end
  class Interrupt < Error; end
  class ArgumentError < Error; end
  class ScriptNotFound < Error; end

  class ScriptError < Error
    attr_reader :error

    def initialize(error)
      @error = error
      trace = error.backtrace_locations.first
      message = error.message.gsub(/ for #<Colorly::Script.*>/, '')
      super "#{trace.path}:#{trace.lineno}: #{message}"
    end
  end

  class ScriptSyntaxError < Error
    def initialize(error)
      super error.message
    end
  end
end
