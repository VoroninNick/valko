class AddSkylightReferenceToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :skylight
    end
  end
end
