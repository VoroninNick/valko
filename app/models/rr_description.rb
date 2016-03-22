# t.string :title
# t.text :description
# t.text :short_description
class RrDescription < ActiveRecord::Base
  attr_accessible *attribute_names

  has_one :roof_rail_item

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
      field :description, :ck_editor do
        label 'Повний пис:'
      end
    end
  end
end
