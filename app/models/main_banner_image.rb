class MainBannerImage < ActiveRecord::Base
  attr_accessible *attribute_names
  belongs_to :main_banner

  attr_accessible :image
  has_attached_file :image,
                    styles: { large: "1400x550>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  rails_admin do
    visible false
    field :title do
      label 'Назва:'
    end
    field :published do
      label 'Чи публікувати?'
    end
    field :position do
      label 'Позиція:'
    end
    field :image, :paperclip do
      label 'Зображення'
      help 'розмір зображення 1400x550.'
    end
  end


  scope :sort_by_position, ->(){
    order(position: 'asc')
  }

end
