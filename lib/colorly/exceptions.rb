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
      super "Something is wrong in #{trace.path} line #{trace.lineno}\n#{message}"
    end
  end
end


