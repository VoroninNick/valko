class AddStatusToFastener < ActiveRecord::Migration
  def change
    change_table :fasteners do |t|
      t.boolean :status
    end
  end
end
