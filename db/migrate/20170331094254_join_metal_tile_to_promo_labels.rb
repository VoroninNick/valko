class JoinMetalTileToPromoLabels < ActiveRecord::Migration
  def change
    create_join_table :metal_tiles, :promo_labels
  end
end
