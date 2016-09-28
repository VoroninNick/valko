# t.string :title
# t.string :slug
#
# t.text :short_description
# t.text :description
# t.boolean :published
#
# t.string :side_face
# t.string :condensation
# t.string :glass
# t.string :furniture
# t.string :handle
# t.text :present_color
#
# t.attachment :avatar
# t.attachment :avatar_plus

class WindowAndDoorItem < ActiveRecord::Base
  attr_accessible *attribute_names

  attr_accessible :avatar, :avatar_plus
  has_attached_file :avatar,
                    styles: { large: "340x340>", thumb: "120x120>"},
                    convert_options: { large: "-quality 94 -interlace Plane", thumb: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_attached_file :avatar_plus,
                    styles: { large: "340x340>", thumb: "120x120>"},
                    convert_options: { large: "-quality 94 -interlace Plane", thumb: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar_plus, content_type: /\Aimage\/.*\Z/

  before_save { save_slug(title, slug) }

  has_many :window_and_door_colors
  attr_accessible :window_and_door_colors
  accepts_nested_attributes_for :window_and_door_colors, allow_destroy: true
  attr_accessible :window_and_door_colors_attributes

  rails_admin do
    navigation_label 'Вікна двері'

    label 'Вікна двері'
    label_plural 'Вікна двері'


    edit do
      field :title do
        label 'Назва:'
      end
      field :short_description do
        html_attributes rows: 10, cols: 100
        label 'Короткий опис:'
      end
      field :avatar, :paperclip do
        label 'Аватар:'
        help 'розмір зображення 340 x 340'
      end
      field :avatar_plus, :paperclip do
        label 'Аватар plus:'
        help 'розмір зображення 340 x 340'
      end

      field :side_face do
        label 'Профіль:'
      end
      field :condensation do
        label 'Ущільнення:'
      end
      field :glass do
        label 'Склопакет:'
      end
      field :furniture do
        label 'Фурнітура:'
      end
      field :handle do
        label 'Ручка:'
      end
      field :present_color do
        html_attributes rows: 5, cols: 100
        label 'Кольори:'
      end

      field :window_and_door_colors do
        label 'Доступні варіанти (кольори):'
      end
      # group :gallery do
      #   label 'Галерея'
      #   active false
      #   field :photo_galleries do
      #     label 'Фотогалерея:'
      #   end
      #   field :video_published do
      #     label 'Чи публікувати відео?:'
      #   end
      #   field :video_title do
      #     label 'Назва відео:'
      #   end
      #   field :video_url do
      #     label 'Лінк на відео:'
      #   end
      #   field :video_poster, :paperclip do
      #     label 'Відео постер:'
      #     help 'розмір зображення 440x300'
      #   end
      #
      # end
    end
  end

  scope :with_public, -> { where(:published => true).order('created_at asc')}
end
