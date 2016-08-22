# t.text :description
# t.string :title

class WindowsillPage < ActiveRecord::Base
  attr_accessible *attribute_names

  rails_admin do
    navigation_label 'Підвіконня відливи'

    label 'Сторінка каталога'
    label_plural 'Сторінки каталога'

    list do

    end
    edit do
      field :title do
        label 'Назва:'
      end
      field :description, :ck_editor do
        label 'Текст сторінки:'
      end
    end

  end
end
