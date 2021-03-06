class GraphViz
  module Type
    struct GVColorList
      def initialize(@data : Array(GVColor))
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVColor
          return GVColorList.new [a]
        when .is_a? GVColorList
          return a
        when .is_a? String
          if a.includes?(";")
            return fractional_colorlist(a)
          end
          return GVColorList.new a.split(":").map { |x| GVColor.gv_parse x }
        when .is_a? Enumerable
          return GVColorList.new a.map { |x| GVColor.gv_parse x }
        else
          raise ArgumentError.new "#{a} cannot be used as ColorList"
        end
      end

      def self.fractional_colorlist(val)
        x, temp = val.split(";")
        y, z = temp.split(":")
        GVColorList.new [GVColor.new("#{x};#{y.to_f64.round(2)}:#{z}")]
      end

      def to_gv(io)
        @data[0].to_gv io
        (1...@data.size).each do |idx|
          io << ':'
          @data[idx].to_gv io
        end
      end

      def to_gv
        "\"" + String.build do |io|
          to_gv io
        end.to_s + "\""
      end
    end
  end
end
