# t.string :title
# t.text :description
# t.text :short_description
# t.attachment :drawing

# t.string :video_title
# t.string :video_url
# t.attachment :video_poster
# t.boolean :video_published
class RrDescription < ActiveRecord::Base
  attr_accessible *attribute_names

  has_one :roof_rail_item
  attr_accessible :drawing
  has_attached_file :drawing,
                    styles: { large: "970x180>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :drawing, content_type: /\Aimage\/.*\Z/

  attr_accessible :video_poster
  has_attached_file :video_poster,
                    styles: { large: "440x300>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :video_poster, content_type: /\Aimage\/.*\Z/

  has_many :photo_galleries, as: :imageable
  attr_accessible :photo_galleries
  accepts_nested_attributes_for :photo_galleries, allow_destroy: true
  attr_accessible :photo_galleries_attributes

  has_and_belongs_to_many :promo_labels
  attr_accessible :promo_label_ids
  has_and_belongs_to_many :promotions

  has_and_belongs_to_many :informations, join_table: :decking_informations
  attr_accessible :informations, :information_ids

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Профнастил'
    label_plural 'Профнастили'

    edit do
      field :status do
        label 'Статус (Нове!):'
      end
      field :promo_labels do
        label 'Іконки акцій:'
      end
      field :title do
        label 'Назва:'
      end
      field :short_description do
        html_attributes rows: 10, cols: 100
        label 'Короткий опис:'
      end
      field :drawing, :paperclip do
        label 'Креслення:'
        help 'розмір зображення 970 x 180'
      end
      field :description, :ck_editor do
        label 'Повний пис:'
      end

      group :gallery do
        label 'Галерея'
        active false
        field :photo_galleries do
          label 'Фотогалерея:'
        end
        field :video_published do
          label 'Чи публікувати відео?:'
        end
        field :video_title do
          label 'Назва відео:'
        end
        field :video_url do
          label 'Лінк на відео:'
        end
        field :video_poster, :paperclip do
          label 'Відео постер:'
          help 'розмір зображення 440x300'
        end

      end
    end
  end
end
