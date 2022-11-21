require 'chroma'

module StringRefinements
  refine String do
    def spin(*args)
      paint.spin(*args)
    end

    def brighten(*args)
      paint.brighten(*args)
    end

    def lighten(*args)
      paint.lighten(*args)
    end

    def darken(*args)
      paint.darken(*args)
    end

    def saturate(*args)
      paint.saturate(*args)
    end

    def desaturate(*args)
      paint.desaturate(*args)
    end

    def greyscale
      paint.greyscale
    end
    alias_method :grayscale, :greyscale

    def palette(*args)
      paint.palette(*args)
    end
  end
end
