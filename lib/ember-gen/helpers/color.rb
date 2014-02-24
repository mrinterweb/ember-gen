
module EmberGen
  module Helpers
    module Color
      COLORS = %w[black red green yellow blue magenta cyan white]
      COLORS.each_with_index do |color, i|
        define_method(color.to_sym) do |str|
          wrapper(i, str)
        end
      end

      def color(str, color)
        unless color.kind_of?(Integer)
          color = COLORS.find_index(color.to_s)
        end
        wrapper(color.to_s, str)
      end

      private

      def wrapper(color_code, str)
        "\033[3#{color_code}m#{str}\033[0m"
      end
    end

  end
end
