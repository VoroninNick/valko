class AddMembraneToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :membrane
    end
  end
end
