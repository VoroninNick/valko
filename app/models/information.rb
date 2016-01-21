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
      end
      field :position do
        label 'Позиція:'
      end
      # field :slug do
      #   label 'Транслітерація:'
      # end
    end
  end
  scope :with_public, -> { where(:published => true).order('position asc')}
  scope :with_main, -> {with_public.where(:main => true)}
end
