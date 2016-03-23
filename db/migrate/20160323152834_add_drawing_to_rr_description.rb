class AddDrawingToRrDescription < ActiveRecord::Migration
  def change
    change_table :rr_descriptions do |t|
      t.attachment :drawing
    end
  end
end
