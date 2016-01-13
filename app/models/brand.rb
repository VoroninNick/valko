# t.string :title
# t.string :slug
# t.attachment :avatar
# t.text :short_description
# t.text :description
class Brand < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :avatar
  has_attached_file :avatar,
                    styles: { large: "1449x549>",
                              medium: "720x400>" },
                    convert_options: { large: "-quality 94 -interlace Plane",
                                       medium: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :windowsills
  def to_slug
    title.parameterize
  end
  def save_slug
    self.slug = to_slug
  end
  before_save :save_slug

  rails_admin do
    navigation_label 'Підвіконня'

    label 'Бренд'
    label_plural 'Бренд'

    edit do
      field :title do
        label 'Назва:'
      end
      field :avatar, :paperclip do
        label 'Аватарка:'
      end
      field :description, :ck_editor do
        label 'Опис:'
      end
    end
  end
end
