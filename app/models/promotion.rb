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

  def to_slug
    title.parameterize
  end
  def save_slug
    self.slug = to_slug
  end
  before_save :save_slug

  rails_admin do
    # navigation_label 'Акційні прайси'
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
      end
      field :start_date do
        label 'Дата початку:'
      end
      field :date_of do
        label 'Дата завершення:'
      end
      field :position do
        label 'Позиція:'
      end
    end
  end
  scope :with_date, -> { where("date_of > ?", Date.today).order('created_at desc')}
  # scope :published, where(published: 't').order(position: :desc)
end
