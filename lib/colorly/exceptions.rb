module Colorly
  class Error < StandardError; end
  class Interrupt < Error; end
  class ArgumentError < Error; end
  class ScriptNotFound < Error; end
end
