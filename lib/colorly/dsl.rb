require 'chroma'

module Colorly
  module DSL
    def reset
      @html = []
    end

    def note(message)
      @html << "<h2>#{message}</h2>"
    end

    def last
      @last ||= 'red'.paint
    end

    def add(col)
      if col.is_a? Array
        col.each { |c| add c }
      else
        @last = col.is_a?(String) ? col.paint : col
        add_color
      end
    end

    def save(path = 'out.html')
      File.write path, "#{style}<table>#{rows}</table>"
      puts "Saved #{path}"
      @saved = true
    end

    def saved?
      @saved
    end

  private

    def add_color
      css_class = last.dark? ? 'dark color' : 'light color'
      @html << "<div class='#{css_class}' style='background-color:#{last}'>#{last.to_hex.upcase}<br>#{last.shade}<br>#{last.name}</div>"
    end

    def rows
      @html.join "\n"
    end

    def style
      <<-STYLE
        <style>
          * { font-family: arial; font-size: 14px }
          
          body { padding: 10px }
          html { padding-bottom: 100px }
          
          .color {
            float: left;
            width: 120px;
            height: 120px;
            padding: 10px 10px 10px 10px;
            border: 2px solid white;
            border-radius: 10px;
          }
          
          .dark { color: white }
          
          h2 {
            font-size: 20px;
            margin: 0;
            padding: 20px 0 5px 0;
            clear: both;
          }
        </style>
      STYLE
    end
  end
end