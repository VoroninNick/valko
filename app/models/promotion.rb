# t.string :title
# t.string :slug
# t.attachment :cover
# t.text :short_description
# t.text :description
# t.boolean :published
# t.integer :position
# t.boolean :main

# t.date :start_date
# t.date :date_of

class Promotion < ActiveRecord::Base
  # self.table_name = :promotions

  attr_accessible *attribute_names
  attr_accessible :cover
  has_attached_file :cover,
                    styles: { large: "1449x549>",
                              medium: "720x400>" },
                    convert_options: { large: "-quality 94 -interlace Plane",
                                       medium: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  before_save { save_slug(title, slug) }


  def set_start_date
    self.start_date ||= Date.today
  end

  def random_date_in_year(year)
    return rand(Date.civil(year.min, 1, 1)..Date.civil(year.max, 12, 31)) if year.kind_of?(Range)
    rand(Date.civil(year, 1, 1)..Date.civil(year, 12, 31))
  end
  def set_date_of
    self.date_of ||= random_date = random_date_in_year(2016..2020)
  end

  before_save :set_start_date, :set_date_of

  has_and_belongs_to_many :windowsills, join_table: :table_windowsills_promotions
  attr_accessible :windowsill_ids
  has_and_belongs_to_many :mosquito_items
  attr_accessible :mosquito_item_ids
  has_and_belongs_to_many :rr_descriptions
  attr_accessible :rr_description_ids

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes

  rails_admin do
    navigation_label 'Інше'

    label 'Акційна пропозиція'
    label_plural 'Акційні пропозиції'

    edit do
      field :published do
        label 'Чи публікувати?'
      end
      field :main do
        label 'Вибрана?'
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
      field :start_date do
        label 'Дата початку:'
      end
      field :date_of, :date do
        label 'Дата завершення:'
      end
      field :position do
        label 'Позиція:'
      end
      group :windowsill_group do
        label 'Підвіконня'
        active false
        field :windowsills do
          label 'Підвіконня:'
        end
      end
      group :mosquito_grid_group do
        label 'Москітні сітки'
        active false
        field :mosquito_items do
          label 'Москітні сітки:'
        end
      end
      group :roof_rails_froup do
        label 'Профнастил'
        active false
        field :rr_descriptions do
          label 'Профнастил:'
        end
      end


      field :seo do
        label 'SEO'
      end
    end
  end
  scope :with_date, -> { where("date_of > ?", Date.today).order('created_at desc')}
  scope :published, -> { where(published: 't').order(position: :desc) }

  searchable do
    text :title, :short_description, :description
  end
end
