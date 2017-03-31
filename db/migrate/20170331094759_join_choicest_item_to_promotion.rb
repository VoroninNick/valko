class JoinChoicestItemToPromotion < ActiveRecord::Migration
  def change
    create_join_table :choicest_items, :promotions
  end
end
