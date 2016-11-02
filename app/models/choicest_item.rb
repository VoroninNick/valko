class ChoicestItem < ActiveRecord::Base
  extend Enumerize
  attr_accessible *attribute_names

  # has_one :metal_tile_detail
  has_many :choicest_item_details
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

  enumerize :appointment, in: [:'to_roof', :'to_fence']
  # has_and_belongs_to_many :informations, join_table: :decking_informations
  # attr_accessible :informations, :information_ids

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Добірний елемент'
    label_plural 'Добірні елементи'

    list do
      # field :title
      # field :slug
    end

    edit do

      field :appointment do
        label 'Призначення:'
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
        label 'Повний опис:'
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

  scope :appointment_item , -> (appointment) {
    where("appointment = ?", appointment)
  }
end
