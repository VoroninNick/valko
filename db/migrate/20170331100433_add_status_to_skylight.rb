class AddStatusToSkylight < ActiveRecord::Migration
  def change
    change_table :skylight_models do |t|
      t.boolean :status
    end
  end
end
