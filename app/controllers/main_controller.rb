class MainController < ApplicationController
  before_action :set_cart, only: [:basket, :dev2]
  after_action :recently_viewed, only: :one_windowsill

  require 'json'

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
    @testimonials = Testimonial.published.post_on_index.limit(4)

    @windowsill_new = Windowsill.with_public

    response_nbu = HTTParty.get('http://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json', timeout: 10) rescue nil
    if response_nbu
    case response_nbu.code
      when 200
        if response_nbu
          @data_nbu = JSON.parse(response_nbu.body)
          @usd_nbu = @data_nbu.select {|key| key["r030"] == 840 }
          @eur_nbu = @data_nbu.select {|key| key["r030"] == 978 }
        else
          []
        end
      when 404
        puts "O noes not found!"
      when 500...600
        puts "ZOMG ERROR #{response.code}"
    end
    end
    # response_nbu = nil
    response_private = HTTParty.get('https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5', timeout: 10) rescue nil
    # response_private = nil
    if response_private
    case response_private.code
      when 200
        if response_private
          @data_private = JSON.parse(response_private.body)
          @usd_private = @data_private.select {|key| key["ccy"] == "USD" }
          @eur_private = @data_private.select {|key| key["ccy"] == "EUR" }
        else
          []
        end
      when 404
        puts "O noes not found!"
      when 500...600
        puts "ZOMG ERROR #{response.code}"
    end
    end


    set_seo('holovna')
  end

  def about
    @about_banner = AboutBanner.with_public
    @brands = AboutBrand.order(created_at: :asc)

    @content_page = PageAbout.first
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
    @promotions = Promotion.published

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

    @page = WindowsillPage.first
    set_seo('pidvikonnia')

    # session["main#windowsill"]
    type = params[:filterrific].try{|x| x[:with_type]} || "internal"
    filterrific_session = session["main#windowsill"]
    filterrific_params = params[:filterrific] || {}

    # session["main#windowsill"] = {}
    if filterrific_session.nil? || (type.present? && type != filterrific_session['with_type'])
      filterrific_params = {
          :sorted_by => filterrific_params[:sorted_by] || :title_asc,
          :with_type => type
      }
      # return render inline: "s: #{filterrific_session['with_type']}, p: #{type}"
      session["main#windowsill"] = {}
    end


    @filterrific = initialize_filterrific(
        Windowsill,
        filterrific_params,
        select_options: {
            sorted_by: Windowsill.options_for_sorted_by
        },
        default_filter_params: {}
    ) or return

    # return render inline: session["main#windowsill"].inspect

    @windowsill_list = @filterrific.find

    #type = params[:filterrific].try{|x| x[:with_type]}
    # if type.present?
    #   session["main#windowsill"]['with_type'] = type
    # end
    # @windowsill_list = Windowsill.with_type(type, @windowsill_list)
    # return render inline: @windowsill_list.inspect
    @windowsill_list = @windowsill_list.page(params[:page])

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
    # @query = Windowsill.search do
    #   fulltext params[:search]
    # end
    # @items = @query.results
    # render inline: session["main#windowsill"].keys.inspect

    # response = HTTParty.get('https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5')
    # @data = JSON.parse(response.body)
    #
    # @usd = @data.select {|key| key["r030"] == 840 }
  end
  def dev2

  end
  def dev3
    
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

  def order_product
    data = params.permit(:first_name, :last_name, :phone_number, :email, :message, :shipping, :cart_id)
    ContactMailer.order_products(data).deliver
    head :ok
  end

  def finish_step_basket
    @cart = Cart.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def search
    @search = Sunspot.search [Windowsill, Promotion, Information, Gag] do
      fulltext params[:search]
    end

    if @search.results.any?
      @items = @search.results
    else
      # return redirect_to request.referrer
    end
    set_meta_tags site: 'Пошук',
                  title: 'Сторінка пошуку'
                  # description: @static_page.seo.try(:seo_description),
                  # keywords: @static_page.seo.try(:keywords)
  end


  def sitemap
    
  end
end
