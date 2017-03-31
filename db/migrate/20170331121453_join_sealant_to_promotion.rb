class JoinSealantToPromotion < ActiveRecord::Migration
  def change
    create_join_table :promotions, :sealants
  end
end
