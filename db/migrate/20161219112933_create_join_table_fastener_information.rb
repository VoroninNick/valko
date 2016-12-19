class CreateJoinTableFastenerInformation < ActiveRecord::Migration
  def change
    create_join_table :fasteners, :information
  end
end
