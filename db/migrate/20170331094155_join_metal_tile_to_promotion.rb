class JoinMetalTileToPromotion < ActiveRecord::Migration
  def change
    create_join_table :metal_tiles, :promotions
  end
end
