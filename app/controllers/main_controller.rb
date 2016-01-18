class MainController < ApplicationController
  def index
    @publications = Information.with_main.limit(5)
    @windowsill_new = Windowsill.new_items.limit(12)
  end

  def about
  end

  def publications
    @main_publication = Information.with_main.first
    @documents = InformationDocument.with_public
    @publications = Information.with_public.where.not(id: @main_publication)
  end
  def publication
    @publication = Information.find_by_slug(params[:title])
    @other_publications = Information.with_public.where.not(id: @publication)
  end

  def promotions
    @promotions = Promotion.all
  end
  def one_promotions
    @one_promotion = Promotion.find_by_slug(params[:title])
    @other_promotions = Promotion.where.not(id: @one_promotion)
  end

  def contacts
  end

  def warranty
  end

  def windowsill
    @windowsill_list = Windowsill.with_public
  end
  def one_windowsill
    @windowsill = Windowsill.first
  end
  
end
