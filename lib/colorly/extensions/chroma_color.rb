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
    distance = nil
    result = nil

    Colorly.color_names.each do |this_hex, this_name, this_shade|
      this_hex = "##{this_hex}"
      if to_hex == this_hex
        return {
          name:  this_name,
          shade: this_shade,
        }
      end

      candidate_distance = color_distance this_hex.paint

      next unless !distance || (distance > candidate_distance)

      distance = candidate_distance
      result = {
        name:  this_name,
        shade: this_shade,
      }
    end

    result
  end

  def color_distance(other)
    rgb_distance(other) + (hsl_distance(other) * 2)
  end

  def rgb_distance(other)
    r1, g1, b1 = rgb
    r2, g2, b2 = other.rgb

    ((r1 - r2)**2) + ((g1 - g2)**2) + ((b1 - b2)**2)
  end

  def hsl_distance(other)
    h1, s1, l1 = hsl
    h2, s2, l2 = other.hsl

    (((h1 - h2)**2).abs / 360.0) +
      ((s1 - s2)**2).abs +
      ((l1 - l2)**2).abs
  end
end
