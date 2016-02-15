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

  end
end
