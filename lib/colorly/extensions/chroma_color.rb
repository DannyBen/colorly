require 'chroma'

class Chroma::Color
  def name
    name_info[:name]
  end

  def shade
    name_info[:shade]
  end

protected

  def name_info
    @name_info ||= name_info!
  end

  def name_info!
    r, g, b = rgb
    h, s, l = hsl
    ndf1 = 0
    ndf2 = 0
    ndf = 0
    df = nil
    result = nil

    Colorly.color_names.each do |this_hex, this_name, this_shade|
      this_hex = "##{this_hex}"
      if to_hex == this_hex
        return {
          name: this_name, 
          shade: this_shade,
        }
      end

      r2, g2, b2 = this_hex.paint.rgb.to_a
      h2, s2, l2 = this_hex.paint.hsl.to_a

      ndf1 = (r - r2) ** 2 + 
             (g - g2) ** 2 + 
             (b - b2) ** 2
      ndf2 = (((h - h2) ** 2).abs / 360.0) + 
             ((s - s2) ** 2).abs + 
             ((l - l2) ** 2).abs

      ndf = ndf1 + ndf2 * 2

      if !df or df > ndf
        df = ndf
        result = {
          name: this_name, 
          shade: this_shade,
        }
      end
    end

    result
  end
end
