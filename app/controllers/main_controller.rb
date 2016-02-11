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

  def set_seo(key)
    @static_page = Page.find_by_slug(key)
    set_meta_tags site: 'Валько',
                  title: @static_page.seo.try(:seo_title),
                  description: @static_page.seo.try(:seo_description),
                  keywords: @static_page.seo.try(:keywords)
  end



  def index
    # return render inline: session.keys.inspect
    @publications = Information.with_main.limit(5)
    @windowsill_new = Windowsill.with_public

    set_seo('holovna')
  end

  def about
    @about_banner = AboutBanner.with_public
    @brands = AboutBrand.order(created_at: :asc)

    set_seo('pro-nas')
  end

  def publications
    @main_publication = Information.with_main.first
    @documents = InformationDocument.with_public
    @publications = Information.with_public.where.not(id: @main_publication)

    set_seo('informatsiia')
  end
  def publication
    @publication = Information.find_by_slug(params[:title])
    @other_publications = Information.with_public.where.not(id: @publication)

    set_meta_tags site: 'Валько',
                  title: @publication.seo.try(:seo_title),
                  description: @publication.seo.try(:seo_description),
                  keywords: @publication.seo.try(:keywords),
                  og: {
                    title: @publication.title,
                    image:    {
                                   _: root_url+@publication.cover.url(:large),
                                   # _: full_image_path(@publication.cover.url(:large)),
                                   width: 170,
                                   height: 75,
                               },
                    description: @publication.short_description,
                    url: request.original_url
                  }

  end

  def promotions
    @promotions = Promotion.all

    set_seo('aktsii')
  end
  def one_promotions
    @one_promotion = Promotion.find_by_slug(params[:title])
    @other_promotions = Promotion.where.not(id: @one_promotion)

    set_meta_tags site: 'Валько',
                  title: @one_promotion.seo.try(:seo_title),
                  description: @one_promotion.seo.try(:seo_description),
                  keywords: @one_promotion.seo.try(:keywords),
                  og: {
                      title: @one_promotion.title,
                      image:    {
                          _: root_url+@one_promotion.cover.url(:large),
                          # _: full_image_path(@publication.cover.url(:large)),
                          width: 150,
                          height: 75,
                      },
                      description: @one_promotion.short_description,
                      url: request.original_url
                  }
  end

  def contacts
    set_seo('kontakty')
  end

  def warranty
    set_seo('dostavka-ta-harantiia')
  end

  def windowsill
    @gags = Gag.all
    set_seo('pidvikonnia')

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
                  title: @windowsill.seo.try(:seo_title),
                  description: @windowsill.seo.try(:seo_description),
                  keywords: @windowsill.seo.try(:keywords)
  end
  def gag
    @gag = Gag.find_by_slug(params[:title])
    @similar_gags = Gag.where.not(id: @gag)

    set_meta_tags site: 'Валько',
                  title: @gag.seo.try(:seo_title),
                  description: @gag.seo.try(:seo_description),
                  keywords: @gag.seo.try(:keywords)
  end
  def basket
    set_seo('korzyna')
  end

  def terms
    @current_terms = TermsOfUse.if_published.first

    set_seo('pravyla-korystuvannia')
  end
  def warranty
    @warranty = Warranty.if_published.first

    set_seo('dostavka-ta-harantiia')
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
