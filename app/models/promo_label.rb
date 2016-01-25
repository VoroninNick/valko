# t.string :title
# t.string :slug
# t.attachment :icon
# t.integer :position
# t.boolean :published
class PromoLabel < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :icon
  has_attached_file :icon,
                    styles: { large: "100x100>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/

  has_and_belongs_to_many :windowsills, join_table: :table_windowsills_promo_labels

  before_save { save_slug(title, slug) }

  rails_admin do
    navigation_label 'Підвіконня'

    label 'Акція іконка'
    label_plural 'Акція іконки'

    field :title do
      label 'Назва:'
    end
    field :icon, :paperclip do
      label 'Іконка:'
      help 'розмір 100 х 100'
    end
  end
end
