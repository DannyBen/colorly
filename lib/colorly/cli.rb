module Colorly
  class CLI
    def self.router
      router = MisterBin::Runner.new version: VERSION,
        header: "Colorly Color Palette Tools"

      router.route_all to: Command
      router
    end
  end
end
