class WindowAndDoorController < ApplicationController

  def index
    @page = WindowAndDoorPage.find_by_page_name('mataloplastykovi-vikna-i-dveri')
    @products = WindowAndDoorItem.all

    set_meta_tags title: @page.seo.try(:seo_title),
                  description: @page.seo.try(:seo_description),
                  keywords: @page.seo.try(:keywords)
  end
end
