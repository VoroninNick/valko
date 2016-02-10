# t.string :title
# t.string :slug
# t.belongs_to :brand
# t.attachment :image
# t.text :description
# t.boolean :published
# t.integer :price
class Gag < ActiveRecord::Base

  def to_slug
    "#{brand.slug}-#{id}-#{title.parameterize}"
  end
  def save_slug
    self.slug = to_slug
  end
  before_save :save_slug

  attr_accessible *attribute_names

  attr_accessible :image
  has_attached_file :image,
                    styles: { thumb: "580x580>",
                              large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :brand
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes

  rails_admin do
    navigation_label 'Підвіконня'

    label 'Заглушка'
    label_plural 'Заглушка'
    edit do
      field :published do
        label 'Чи публікувати?:'
      end
      field :title do
        label 'Назва:'
      end
      field :brand do
        label 'Бренд:'
      end
      field :image, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 1400x840'
      end
      field :price do
        label 'Ціна:'
      end
      field :description do
        html_attributes rows: 10, cols: 100
        label 'Опис:'
      end
      field :seo do
        label 'SEO'
      end
    end
  end

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
