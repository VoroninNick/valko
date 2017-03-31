class JoinChoicestItemToPromoLabel < ActiveRecord::Migration
  def change
    create_join_table :choicest_items, :promo_labels
  end
end
