# t.string :title
# t.attachment :image
# t.belongs_to :windowsill
class WindowsillPhoto < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :image
  has_attached_file :image,
                    styles: { thumb: "280x280>",
                              large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :windowsill

  rails_admin do
    visible false
    edit do
      field :image, :paperclip do
        label 'Зображення:'
      end
    end
  end
end
