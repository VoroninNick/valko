class MosquitoItemsPromotions < ActiveRecord::Migration
  def change
    create_join_table :mosquito_items, :promotions
  end
end
