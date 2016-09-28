# t.string :title
# t.integer :position
# t.belongs_to :window_and_door
# t.attachment :image

class WindowAndDoorColor < ActiveRecord::Base
  attr_accessible *attribute_names

  attr_accessible :image
  has_attached_file :image,
                    styles: { large: "800x800>", thumb: "120x120>"},
                    convert_options: { large: "-quality 94 -interlace Plane", thumb: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :window_and_door_item

  rails_admin do
    label 'Одиниця каталогу - варіанти кольору'
    label_plural 'Одиниця каталогу - варіант кольору'

    visible false
    edit do
      field :title do
        label 'Назва:'
      end
      field :image, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 800x800'
      end
    end
  end
end
