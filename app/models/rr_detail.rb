# t.string :title
# t.attachment :image
# t.integer :price
# t.boolean :published
# t.belongs_to :roof_rail_item
class RrDetail < ActiveRecord::Base
  attr_accessible *attribute_names
  belongs_to :roof_rail_item
  attr_accessible :image
  has_attached_file :image,
                    styles: { thumb: "580x580>",
                              large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  extend Enumerize
  enumerize :title, in: [:'g6005', :'g3005', :'g9003', :'g1003', :'g8017', :'g8004', :'g1015', :'g9006', :'g5005', :'g3011', :'g3009', :'ghorikh', :'gzolotyy-dub', :'m6005', :'m8004', :'m8017', :'m8019', :'m3005', :'m7024', :'m6020', :'m3009', :'mtsynk', :'malyutsynk']


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
