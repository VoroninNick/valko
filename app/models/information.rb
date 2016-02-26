# t.string :type
# t.string :title
# t.string :slug
# t.attachment :cover
# t.text :short_description
# t.text :description
# t.boolean :published
# t.integer :position
# t.boolean :main

class Information < ActiveRecord::Base

  before_save { save_slug(title, slug) }

  attr_accessible *attribute_names
  attr_accessible :cover

  has_attached_file :cover,
                    styles: { large: "1449x549>",
                              medium: "720x400>" },
                    convert_options: { large: "-quality 94 -interlace Plane",
                                       medium: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  has_and_belongs_to_many :windowsills, join_table: :table_windowsills_informations
  attr_accessible :windowsill_ids

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes
  rails_admin do
    navigation_label 'Інформація'
    label 'Публікація'
    label_plural 'Публікації (Інформація)'

    edit do
      field :published do
        label 'Чи публікувати?'
      end
      field :main do
        label 'Вибрана?'
        help 'На головну'
      end
      field :title do
        label 'Назва:'
      end
      field :cover, :paperclip do
        label 'Зображення:'
      end
      field :short_description do
        html_attributes rows: 10, cols: 100
        label 'Короткий опис:'
      end
      field :description, :ck_editor do
        label 'Опис:'
        help 'Використовувати теги h3, h4, h5, h6, p, blockquote, <ul or ol> <li> <span>text</span></li></ul or /ol>'
      end
      field :position do
        label 'Позиція:'
      end
      field :windowsills do
        label 'Підвіконня:'
      end
      field :seo do
        label 'SEO'
      end
    end
  end
  scope :with_public, -> { where(:published => true).order('position asc')}
  scope :with_main, -> {with_public.where(:main => true)}

  searchable do
    text :title, :short_description, :description
  end
end
