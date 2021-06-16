require "mister_bin"
require "colsole"

module Colorly
  module Commands
    class Base < MisterBin::Command
      include Colsole
    end
  end
end
