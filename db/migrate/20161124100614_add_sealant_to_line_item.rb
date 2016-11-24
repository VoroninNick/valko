class AddSealantToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :sealant
    end
  end
end
