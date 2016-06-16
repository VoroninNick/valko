class AddGalleryColumnsToMosquito < ActiveRecord::Migration
  def change
    MosquitoItem.add_gallery_columns(self)
  end
end
