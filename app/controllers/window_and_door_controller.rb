class WindowAndDoorController < ApplicationController

  def index
    @page = WindowAndDoorPage.find_by_page_name('mataloplastykovi-vikna-i-dveri')
    @products = WindowAndDoorItem.with_public

    set_meta_tags title: @page.seo.try(:seo_title),
                  description: @page.seo.try(:seo_description),
                  keywords: @page.seo.try(:keywords)
  end

  def order_product
    data = params.permit(:product, :phone)
    ContactMailer.wd_order_product(data).deliver
    head :ok
  end

end
