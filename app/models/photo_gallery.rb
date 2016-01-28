# t.string :title
# t.string :alt
# t.has_attached_file :image
# t.integer :imageable_id
# t.string :imageable_type
class PhotoGallery < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type, :image, :title, :alt

  belongs_to :imageable, polymorphic: true

  has_attached_file :image,
                    styles: { thumb: "220x140>",
                        large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                        large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  rails_admin do
    label 'Фотогалерея'
    label_plural 'Фотогалереї'
    visible false
    edit do
      field :title do
        label 'Назва:'
      end
      # field :alt do
      #   label 'Алтернативний текст:'
      # end
      field :image, :paperclip do
        label 'Зображення'
        help 'розмір зображення 1400x840.'
      end
    end
  end
  scope :with_public, -> { where(:published => true).order('created_at asc')}
end
