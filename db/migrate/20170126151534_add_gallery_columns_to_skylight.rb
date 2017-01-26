class AddGalleryColumnsToSkylight < ActiveRecord::Migration
  def change
    SkylightModel.add_gallery_columns(self)
  end
end
