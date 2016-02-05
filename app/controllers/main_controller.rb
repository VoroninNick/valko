class MainController < ApplicationController
  before_action :set_cart, only: [:basket]
  after_action :recently_viewed, only: :one_windowsill

  def recently_viewed
    return unless request.get?
    return if request.xhr?

    session[:recently_viewed] ||= []
    session[:recently_viewed] << @windowsill.id unless session[:recently_viewed].include? @windowsill.id
    session[:recently_viewed].delete_at 0 if session[:recently_viewed].size == 12
  end

  def index
    # return render inline: session.keys.inspect
    @publications = Information.with_main.limit(5)
    @windowsill_new = Windowsill.with_public
  end

  def about
    @about_banner = AboutBanner.with_public
    @brands = AboutBrand.order(created_at: :asc)
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
    @gags = Gag.all
    # @windowsill_list = Windowsill.with_public
    @filterrific = initialize_filterrific(
        Windowsill,
        params[:filterrific],
        select_options: {
            sorted_by: Windowsill.options_for_sorted_by
        }
    ) or return

    @windowsill_list = @filterrific.find.page(params[:page])


    respond_to do |format|
      format.html
      format.js
    end
  end
  def one_windowsill
    @windowsill = Windowsill.find_by_slug(params[:title])
    @similar = Windowsill.where(brand_id: @windowsill.brand_id).where.not(id: @windowsill)
  end
  def gag
    @gag = Gag.find_by_slug(params[:title])
    @similar_gags = Gag.where.not(id: @gag)
  end
  def basket
    
  end

  def dev
    # render inline: session["main#windowsill"].keys.inspect
  end


#   mailer methods
  def offers_and_comments
    # data = params.permit(:name, :phone, :email, :date, :time, :message, cottages: [])
    data = params.permit(:name, :message)
    # return render inline: data.inspect
    ContactMailer.offers_and_comments(data).deliver
    head :ok
  end

  def contact_form
    # data = params.permit(:name, :phone, :email, :date, :time, :message, cottages: [])
    data = params.permit(:name, :phone, :email, :factory, :city, :status, :message)
    # return render inline: data.inspect
    ContactMailer.contact_form(data).deliver
    head :ok
  end
end
