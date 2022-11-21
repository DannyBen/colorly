module Colorly
  module DSL
    def title(title)
      @current_title = title
    end

    def add(color)
      if color.is_a? Array
        color.each { |c| add c }
      else
        output[current_title] ||= []
        register color
        output[current_title] << last
      end
    end

    def last
      @last ||= 'red'.paint
    end

    def random
      '#%06x' % (rand * 0xffffff)
    end
  end
end
