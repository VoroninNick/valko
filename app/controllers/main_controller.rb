class MainController < ApplicationController
  def index
    @publications = Information.with_main.limit(5)
  end
  def publications
    @main_publication = Information.with_main.first
    @documents = InformationDocument.with_public
    @publications = Information.with_public.where.not(id: @main_publication)
  end
  def publication
    @publication = Information.find_by_slug(params[:title])
  end
  def promotions

  end
end
