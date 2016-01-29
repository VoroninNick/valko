Dir[Rails.root.join("lib/*.rb")].each do |f|
  require f
end
# require 'mixin_methods'
# require 'current_cart'