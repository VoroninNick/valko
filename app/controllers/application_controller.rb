class ApplicationController < ActionController::Base
  include CurrentCart
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :set_cart

  def set_seo(key)
    @static_page = Page.find_by_slug(key)
    set_meta_tags title: @static_page.seo.try(:seo_title),
                  description: @static_page.seo.try(:seo_description),
                  keywords: @static_page.seo.try(:keywords)
  end
end
