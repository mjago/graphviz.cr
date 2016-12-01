class GraphViz
  module Type
    enum GVDirType
      Forward
      Back
      Both
      None

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a.capitalize
        when .is_a? GVDirType
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as DirType"
        end
      end
    end
  end
end
