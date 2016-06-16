class CreateJoinTableMosquitoInformation < ActiveRecord::Migration
  def change
    create_join_table :mosquito_items, :information
  end
end
