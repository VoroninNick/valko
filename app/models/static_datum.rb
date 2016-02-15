# t.string :city
# t.string :street
# t.string :tel1
# t.string :tel2

# t.string :facebook
# t.string :youtube
# t.string :google
class StaticDatum < ActiveRecord::Base
  attr_accessible *attribute_names


  rails_admin do
    navigation_label 'Інші'

    label 'Статичні дані'
    label_plural 'Статичні дані'
    edit do
      group :address do
        label 'Адреса'
        field :city do
          label 'Місто:'
        end
        field :street do
          label 'Вулиця:'
        end
      end
      group :phone_numbers do
        label 'Номери телефонів'
        field :tel1 do
          label 'Номер стаціонарного:'
        end
        field :tel2 do
          label 'Номер мобільного:'
        end
      end
      group :socials do
        label 'Лінки на соціальні мережі'
        active false
        field :facebook do
          label 'facebook:'
        end
        field :youtube do
          label 'youtube:'
        end
        field :google do
          label 'google:'
        end
      end
    end
  end
end
