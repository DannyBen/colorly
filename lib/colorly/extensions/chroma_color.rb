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

      this_rgb = this_hex.paint.rgb.to_a
      this_hsl = this_hex.paint.hsl.to_a

      ndf1 = (r - this_rgb[0]) ** 2 + 
             (g - this_rgb[1]) ** 2 + 
             (b - this_rgb[2]) ** 2
      ndf2 = (((h - this_hsl[0]) ** 2).abs / 360.0) + 
             ((s - this_hsl[1]) ** 2).abs + 
             ((l - this_hsl[2]) ** 2).abs

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
