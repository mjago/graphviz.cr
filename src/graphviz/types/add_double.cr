class GraphViz
  module Type
    struct GVAddDouble
      def initialize(@data : Float64, @signed : Bool = false)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVAddDouble
          return a
        when .is_a? Number
          return GVAddDouble.new a.to_f64
        when .is_a? String
          return GVAddDouble.new a.to_f64, a[0] == '+'
        else
          raise ArgumentError.new "#{a} cannot be used as AddDouble"
        end
      end
    end
  end
end