# t.text :top_block
# t.text :bottom_block
class PageAbout < ActiveRecord::Base
  attr_accessible *attribute_names

  rails_admin do
    navigation_label 'Про нас'

    label 'Тексти'
    label_plural 'Тексти'

    field :top_block do
      html_attributes rows: 30, cols: 100
      label '5 ПРИЧИН ОБРАТИ «ВАЛЬКО»:'
    end
    field :bottom_block do
      html_attributes rows: 10, cols: 100
      label 'КОМПАНІЯ «ВАЛЬКО»:'
    end
  end
end
