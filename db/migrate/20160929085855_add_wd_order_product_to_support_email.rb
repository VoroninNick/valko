class AddWdOrderProductToSupportEmail < ActiveRecord::Migration
  def change
    change_table :support_emails do |t|
      t.string :wd_order_product
    end
  end
end
