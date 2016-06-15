class MosquitoController < ApplicationController

  def index
    # moskitni-sitky
    @catalog_page = MosquitoGrid.find_by_page_name('mosquito-grid')

    set_meta_tags title: @catalog_page.seo.try(:seo_title),
                  description: @catalog_page.seo.try(:seo_description),
                  keywords: @catalog_page.seo.try(:keywords)
  end
  def window
    @catalog_sub_page = MosquitoGrid.find_by_page_name('mosquito-grid-window')

    @mg_products = MosquitoItem.where(mosquito_grid_type: :window)

    set_meta_tags title: @catalog_sub_page.seo.try(:seo_title),
                  description: @catalog_sub_page.seo.try(:seo_description),
                  keywords: @catalog_sub_page.seo.try(:keywords)
  end
  def window_item
    @product = MosquitoItem.find_by_slug(params[:title])
  end
end
