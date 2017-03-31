class JoinMembraneToPromotion < ActiveRecord::Migration
  def change
    create_join_table :membranes, :promotions
  end
end
