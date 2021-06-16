require 'chroma'

class String
  def spin(*args)
    paint.spin *args
  end

  def darken(*args)
    paint.darken *args
  end

  def lighten(*args)
    paint.lighten *args
  end

  def saturate(*args)
    paint.saturate *args
  end

  def desaturate(*args)
    paint.desaturate *args
  end

  def palette(*args)
    paint.palette *args
  end
end
