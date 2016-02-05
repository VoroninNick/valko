class CreateSupportEmails < ActiveRecord::Migration
  def change
    create_table :support_emails do |t|
      t.string :cart
      t.string :call_order
      t.string :contact_form
      t.string :offers_and_comments

      t.timestamps null: false
    end
  end
end
