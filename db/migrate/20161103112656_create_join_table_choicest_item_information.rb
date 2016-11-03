class CreateJoinTableChoicestItemInformation < ActiveRecord::Migration
  def change
    create_join_table :choicest_items, :informations
  end
end
