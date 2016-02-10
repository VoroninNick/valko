# t.string :seo_title
# t.text :seo_description
# t.text :keywords
# t.integer :seo_poly_id
# t.string :seo_poly_type

class Seo < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :seo_poly, polymorphic: true

  rails_admin do
    visible false
    list do
      field :seo_title do
        label 'Title'
      end
      field :seo_description do
        label 'Description'
      end
      field :keywords do
        label 'Keywords'
      end
    end
    edit do
      field :seo_title do
        label 'Title'
      end
      field :seo_description do
        html_attributes rows: 5, cols: 100
        label 'Description'
      end
      field :keywords do
        html_attributes cols: 100
        label 'Keywords'
      end
    end
  end
end
