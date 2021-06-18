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
    rgb1 = rgb
    hsl1 = hsl
    distance = nil
    result = nil

    Colorly.color_names.each do |this_hex, this_name, this_shade|
      this_hex = "##{this_hex}"
      if to_hex == this_hex
        return {
          name: this_name, 
          shade: this_shade,
        }
      end

      rgb2 = this_hex.paint.rgb.to_a
      hsl2 = this_hex.paint.hsl.to_a
      candidate_distance = color_distance rgb1, hsl1, rgb2, hsl2

      if !distance or distance > candidate_distance
        distance = candidate_distance
        result = {
          name: this_name, 
          shade: this_shade,
        }
      end
    end

    result
  end

  def color_distance(rgb1, hsl1, rgb2, hsl2)
    rgb_distance(rgb1, rgb2) + hsl_distance(hsl1, hsl2) * 2
  end

  def rgb_distance(rgb1, rgb2)
    r1, g1, b1 = rgb1
    r2, g2, b2 = rgb2

    (r1 - r2) ** 2 + (g1 - g2) ** 2 + (b1 - b2) ** 2
  end

  def hsl_distance(hsl1, hsl2)
    h1, s1, l1 = hsl1
    h2, s2, l2 = hsl2

    (((h1 - h2) ** 2).abs / 360.0) + 
      ((s1 - s2) ** 2).abs + 
      ((l1 - l2) ** 2).abs
  end
end
