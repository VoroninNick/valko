class AddFastenerOptionToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :fastener_option
    end
  end
end
