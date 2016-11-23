# t.string :title
# t.attachment :image
# t.integer :price
# t.boolean :published
#
# t.integer :col_option_id
# t.string :col_option_type

class FastenerColorOption < ActiveRecord::Base
  extend Enumerize
  attr_accessible *attribute_names


  # belongs_to :roof_rail_item
  attr_accessible :image
  has_attached_file :image,
                    styles: { thumb: "580x580>",
                              large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  enumerize :title, in: [:'f3005', :'f6005', :'f6020', :'f3011', :'f3009', :'f5005', :'f1003', :'f1015', :'f8004', :'f8003', :'f8017', :'f8019', :'f7024', :'f9006', :'f9003', :'ftsynk' ]

  rails_admin do
    visible false
    edit do
      field :title do
        label 'Назва:'
      end
      field :image, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 1400x840'
      end
      field :price do
        label 'Ціна:'
      end
    end
  end
end
