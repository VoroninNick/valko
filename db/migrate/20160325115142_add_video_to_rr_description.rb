class AddVideoToRrDescription < ActiveRecord::Migration
  def change
    change_table :rr_descriptions do |t|
      t.string :video_title
      t.string :video_url
      t.attachment :video_poster
      t.boolean :video_published

    end
  end
end
