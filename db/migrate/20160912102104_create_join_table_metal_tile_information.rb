class CreateJoinTableMetalTileInformation < ActiveRecord::Migration
  def change
    create_join_table :metal_tile_details, :information
  end
end
