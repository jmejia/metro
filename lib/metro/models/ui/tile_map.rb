module Metro
  module UI
    class TileMap < ::Metro::Model

      property :file, type: :text
      property :rotation

      attr_accessor :layers
      attr_accessor :viewport

      def map
        @map ||= begin
          map = ::Tmx.load asset_path(file)
          map.tilesets.each {|tileset| tileset.window = window }
          map
        end
      end

      def objects(*types)
        result = map.object_groups.map do |object_group|
          types.map do |type|
            # TODO: provide a more robust query functionality in the TMX gem
            object_group.objects.find_all {|object| object.type == type }
          end
        end.flatten.compact
      end

      def layer_positioning
        { orthogonal: "Metro::Tmx::TileLayer::OrthogonalPositioning",
          isometric: "Metro::Tmx::TileLayer::IsometricPositioning" }[map.orientation.to_sym].constantize
      end

      def show
        self.layers = map.layers.collect do |layer|
          tml = TileLayer.new
          # FIX: change to use composition
          tml.extend layer_positioning
          tml.rotation = rotation
          tml.viewport = viewport
          tml.map = map
          tml.layer = layer
          tml.tilesets = map.tilesets
          tml
        end
      end

      def update
        # update the layer with the current viewport position
      end

      def draw
        layers.each {|layer| layer.draw }
      end
    end
  end
end

require_relative 'tmx/tile_layer'
require_relative 'tmx/isometric_position'
require_relative 'tmx/orthogonal_position'