# t.string :title
# t.string :slug
# t.attachment :avatar
# t.text :short_description
# t.text :description
class Brand < ActiveRecord::Base
  # include MixinMethods  - unless ny nodule included to ActiveRecord from module file

  before_save { save_slug(title, slug) }

  attr_accessible *attribute_names
  attr_accessible :avatar
  has_attached_file :avatar,
                    styles: { large: "350x350>" },
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :windowsills
  has_one :gag

  has_many :brand_icons
  attr_accessible :brand_icons
  accepts_nested_attributes_for :brand_icons, allow_destroy: true
  attr_accessible :brand_icons_attributes

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
        help 'в форматі SVG'
      end
      field :description, :ck_editor do
        label 'Опис:'
        help 'Використовувати теги h3, h4, h5, h6, p, blockquote, (ul, ol) li span'
      end
      field :brand_icons do
        label 'Характеристики:'
      end
    end
  end


  # def self.options_for_select
  #   order('LOWER(title)').map { |e| [e.title, e.id] }
  # end
  def self.brands_list
    order('LOWER(title)').pluck_to_hash(:title, :id, :slug).uniq
  end
end
