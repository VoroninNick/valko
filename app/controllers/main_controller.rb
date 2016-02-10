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

    set_meta_tags site: 'Валько',
                  title: 'Головна сторінка',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end

  def about
    @about_banner = AboutBanner.with_public
    @brands = AboutBrand.order(created_at: :asc)

    set_meta_tags site: 'Валько',
                  title: 'Про нас',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end

  def publications
    @main_publication = Information.with_main.first
    @documents = InformationDocument.with_public
    @publications = Information.with_public.where.not(id: @main_publication)

    set_meta_tags site: 'Валько',
                  title: 'Інформація',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end
  def publication
    @publication = Information.find_by_slug(params[:title])
    @other_publications = Information.with_public.where.not(id: @publication)

    set_meta_tags site: 'Валько',
                  title: @publication.title,
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members',
                  og: {
                    title: @publication.title,
                    image:    {
                                   _: root_url+@publication.cover.url(:large),
                                   # _: full_image_path(@publication.cover.url(:large)),
                                   width: 170,
                                   height: 75,
                               }
                  }

  end

  def promotions
    @promotions = Promotion.all

    set_meta_tags site: 'Валько',
                  title: 'Акції',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end
  def one_promotions
    @one_promotion = Promotion.find_by_slug(params[:title])
    @other_promotions = Promotion.where.not(id: @one_promotion)

    set_meta_tags site: 'Валько',
                  title: @one_promotion.title,
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members',
                  og: {
                      title: @one_promotion.title,
                      image:    {
                          _: root_url+@one_promotion.cover.url(:large),
                          # _: full_image_path(@publication.cover.url(:large)),
                          width: 150,
                          height: 75,
                      }
                  }
  end

  def contacts
    set_meta_tags site: 'Валько',
                  title: 'Контакти',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end

  def warranty
    set_meta_tags site: 'Валько',
                  title: 'Доставка та гарантія',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end

  def windowsill
    @gags = Gag.all

    set_meta_tags site: 'Валько',
                  title: 'Каталог підвіконня',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'

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

    set_meta_tags site: 'Валько',
                  title: @windowsill.title,
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end
  def gag
    @gag = Gag.find_by_slug(params[:title])
    @similar_gags = Gag.where.not(id: @gag)

    set_meta_tags site: 'Валько',
                  title: @gag.title,
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end
  def basket
    set_meta_tags site: 'Валько',
                  title: 'Корзина',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
  end

  def terms
    @current_terms = TermsOfUse.if_published.first

    set_meta_tags site: 'Валько',
                  title: 'Правила користування',
                  description: 'Member login page.',
                  keywords: 'Site, Login, Members'
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
    data = params.permit(:name, :phone, :email, :factory, :city, :status, :message)
    ContactMailer.contact_form(data).deliver
    head :ok
  end

  def call_order
    data = params.permit(:phone)
    ContactMailer.call_order(data).deliver
    head :ok
  end

end
