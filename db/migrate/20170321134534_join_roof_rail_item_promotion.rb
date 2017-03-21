class JoinRoofRailItemPromotion < ActiveRecord::Migration
  def change
    create_join_table :promotions, :rr_descriptions
  end
end
