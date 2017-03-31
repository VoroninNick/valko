class JoinSkylightToPromotion < ActiveRecord::Migration
  def change
    create_join_table :promotions, :skylight_models
  end
end
