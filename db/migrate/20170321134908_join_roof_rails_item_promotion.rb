class JoinRoofRailsItemPromotion < ActiveRecord::Migration
  def change
    create_join_table :promo_labels, :rr_descriptions
  end
end
