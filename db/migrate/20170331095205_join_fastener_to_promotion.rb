class JoinFastenerToPromotion < ActiveRecord::Migration
  def change
    create_join_table :fasteners, :promotions
  end
end
