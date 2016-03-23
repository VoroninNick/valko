# t.string :title
# t.text :description
# t.text :short_description
# t.attachment :drawing
class RrDescription < ActiveRecord::Base
  attr_accessible *attribute_names

  has_one :roof_rail_item
  attr_accessible :drawing
  has_attached_file :drawing,
                    styles: { large: "970x180>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :drawing, content_type: /\Aimage\/.*\Z/

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Покрівля огорожі'
    label_plural 'Покрівля огорожі'

    edit do
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
    end
  end
end
