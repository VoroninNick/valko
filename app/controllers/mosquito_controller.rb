class MosquitoController < ApplicationController

  def index
    # moskitni-sitky
    @catalog_page = MosquitoGrid.find_by_page_name('mosquito-grid')

    if @catalog_page
      set_meta_tags title: @catalog_page.seo.try(:seo_title),
                    description: @catalog_page.seo.try(:seo_description),
                    keywords: @catalog_page.seo.try(:keywords)
    end
  end
  def window
    @catalog_sub_page = MosquitoGrid.find_by_page_name('mosquito-grid-window')

    @mg_products = MosquitoItem.where(mosquito_grid_type: :window)

    render "sub_page"
    if @catalog_sub_page
      set_meta_tags title: @catalog_sub_page.seo.try(:seo_title),
                    description: @catalog_sub_page.seo.try(:seo_description),
                    keywords: @catalog_sub_page.seo.try(:keywords)
    end
  end
  def window_item
    @product = MosquitoItem.find_by_slug(params[:title])
  end
  def door
    @catalog_sub_page = MosquitoGrid.find_by_page_name('mosquito-grid-doors')

    @mg_products = MosquitoItem.where(mosquito_grid_type: :door)

    render "sub_page"
    if @catalog_sub_page
      set_meta_tags title: @catalog_sub_page.seo.try(:seo_title),
                    description: @catalog_sub_page.seo.try(:seo_description),
                    keywords: @catalog_sub_page.seo.try(:keywords)
    end
  end
  def door_item

  end
  def rolling
    @catalog_sub_page = MosquitoGrid.find_by_page_name('mosquito-grid-rolling')

    @mg_products = MosquitoItem.where(mosquito_grid_type: :rolling)

    render "sub_page"
    if @catalog_sub_page
      set_meta_tags title: @catalog_sub_page.seo.try(:seo_title),
                    description: @catalog_sub_page.seo.try(:seo_description),
                    keywords: @catalog_sub_page.seo.try(:keywords)
    end
  end
  def rolling_item

  end
  def sliding
    @catalog_sub_page = MosquitoGrid.find_by_page_name('mosquito-grid-sliding')

    @mg_products = MosquitoItem.where(mosquito_grid_type: :sliding)

    render "sub_page"
    if @catalog_sub_page
      set_meta_tags title: @catalog_sub_page.seo.try(:seo_title),
                    description: @catalog_sub_page.seo.try(:seo_description),
                    keywords: @catalog_sub_page.seo.try(:keywords)
    end
  end
  def sliding_item

  end

  # def calculate_price
  #
  # end
end
