module Metro
  module Units

    #
    # An object that represents a rectanglar bounds.
    #
    class RectangleBounds
      include CalculationValidations

      attr_accessor :left, :right, :top, :bottom

      def self.none
        new left: 0, right: 0, top: 0, bottom: 0
      end

      #
      # Create a bounds with bounds.
      #
      def initialize(params = {})
        @left = params[:left].to_f
        @top = params[:top].to_f
        @right = params[:right].to_f
        @bottom = params[:bottom].to_f
      end

      def top_left
        point_at left, top
      end

      def top_right
        point_at right, top
      end

      def bottom_right
        point_at right, bottom
      end

      def bottom_left
        point_at left, bottom
      end

      def width
        (right - left)
      end

      def height
        (bottom - top)
      end

      def center
        top_left + point_at(width/2,height/2)
      end

      def dimensions
        Dimensions.of width, height
      end

      def ==(value)
        check_calculation_requirements(value)
        left == value.left and right == value.right and top == value.top and bottom == value.bottom
      end

      #
      # Does this bounds contain the following point?
      #
      def contains?(point)
        point.x > left and point.x < right and point.y > top and point.y < bottom
      end

      #
      # Does this rectanglular bounds intersect with another rectanglular bounds?
      #
      def intersect?(b)
        not(b.left > right or b.right < left or b.top > bottom or b.bottom < top)
      end

      def to_s
        "(#{left},#{top}) to (#{right},#{bottom})"
      end

      private

      def point_at(x,y)
        Point.at(x,y)
      end

      def calculation_requirements
        [ :left, :right, :top, :bottom ]
      end

    end

  end
end