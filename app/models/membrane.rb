# t.string :title
# t.string :slug
#
# t.string :appointment
#
# t.attachment :image
# t.text :short_description
# t.float :price
#
# t.text :description
#
# t.string :video_title
# t.string :video_url
# t.attachment :video_poster
# t.boolean :video_published

class Membrane < ActiveRecord::Base
  extend Enumerize
  attr_accessible *attribute_names

  attr_accessible :image
  has_attached_file :image,
                    styles: { thumb: "580x580>",
                              large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  attr_accessible :video_poster
  has_attached_file :video_poster,
                    styles: { large: "440x300>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :video_poster, content_type: /\Aimage\/.*\Z/

  enumerize :appointment, in: [:'vapour_barrier', :'hydro_barrier', :'membrane']

  has_many :photo_galleries, as: :imageable
  attr_accessible :photo_galleries
  accepts_nested_attributes_for :photo_galleries, allow_destroy: true
  attr_accessible :photo_galleries_attributes


  has_many :line_items

  # informations
  # has_and_belongs_to_many :informations, join_table: :choicest_items_information
  # attr_accessible :informations, :information_ids

  before_save { save_slug(title, slug) }

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Покрівельна плівка'
    label_plural 'Покрівельні плівки'

    list do
      # field :title
      # field :slug
    end

    edit do
      field :title do
        label 'Назва:'
      end
      field :appointment do
        label 'Призначення:'
      end
      field :short_description do
        html_attributes rows: 10, cols: 100
        label 'Короткий опис:'
      end
      field :image, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 1400x840'
      end
      field :price do
        label 'Ціна:'
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


  def counted_price
    price.round()
  end

  scope :by_appointment, -> (key) {
    where(appointment: key)
  }



  # def self.test_scope name, body = nil, &block
  #
  #   if block_given?
  #     block.call
  #   end
  #   body.present?
  # end

end
