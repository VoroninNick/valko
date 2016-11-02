class RoofRailingController < ApplicationController

  def index
    # @item = RoofRailItem.select(:rr_description).map(&:rr_description).uniq
    keys = []
    all_rr = RoofRailItem.all
    #keys = @items.map(&:slug)
    @items = all_rr.select { |el|
      if !keys.include?(el.slug)
        keys << el.slug
        next true
      end

      false
    }
    @roof_rail = RoofRailPage.find_by_page_name('pokrivlia-ohorozhi')

    set_meta_tags title: @roof_rail.seo.try(:seo_title),
                  description: @roof_rail.seo.try(:seo_description),
                  keywords: @roof_rail.seo.try(:keywords)
  end

  def deck_list
    # @item = RoofRailItem.select(:rr_description).map(&:rr_description).uniq
    keys = []
    @all_rr = RoofRailItem.all
    #keys = @items.map(&:slug)
    @items = @all_rr.select { |el|
      if !keys.include?(el.slug)
        keys << el.slug
        next true
      end

      false
    }

    @roofs = RrDescription.all

    @decking_list = RoofRailPage.find_by_page_name('profnastyl')

    set_meta_tags title: @decking_list.seo.try(:seo_title),
                  description: @decking_list.seo.try(:seo_description),
                  keywords: @decking_list.seo.try(:keywords)
  end
  def decking
    # @decking = RoofRailItem.where(slug: params[:title]).includes(:rr_details).first
    @decking = RoofRailItem.find_by_slug(params[:title])
    @similar = RrDescription.where.not(id: @decking.rr_description.id)
  end

  def metal_tile_list
    @page = RoofRailPage.find_by_page_name('metalocherepitcja')
    @items = MetalTile.all
  end
  def metal_tile
    @product = MetalTileDetail.find_by_slug(params[:title])
  end

  def sheet_metal_list
    @page = RoofRailPage.find_by_page_name('lystovyj-metal')
    @items = MetalSheet.all
  end
  def sheet_metal
    @product = MetalSheetDetail.find_by_slug(params[:title])
  end


  def choicest_items
    @page = RoofRailPage.find_by_page_name('pokrivelni-dobirni-elementy')
  end
  def choicest_roof_items
    @page = RoofRailPage.find_by_page_name('pokrivelni-dobirni-elementy-do-dachu')
    @items = ChoicestItem.appointment_item "to_roof"
  end
  def choicest_fence_items
    @page = RoofRailPage.find_by_page_name('pokrivelni-dobirni-elementy-do-ogorozhi')
  end
  def choicest_item
    @product = ChoicestItemDetail.find_by_slug(params[:title])
  end



  def get_rr_options
    # received_key = params[:key]
    # producer = received_key.partition('-').first
    # product = received_key.partition('-').last

    product = params[:key]
    producer = params[:producer]
    thickness = params[:thickness]
    coating = params[:coating]
    lamina = params[:lamina]

    params_type = ''
    if producer && !thickness
      params_type = 'producer'
    elsif thickness && !coating
      params_type = 'thickness'
    elsif coating && !lamina
      params_type = 'coating'
    elsif lamina
      params_type = 'lamina'
    end

    decking = RoofRailItem.find_by_slug(product)

    # all producers by product
    producer_by_item = RoofRailItem.where(slug: decking.slug).pluck(:producer).uniq

    # all thickness by producer
    thickness_by_producer = RoofRailItem.where(slug: decking.slug).where(producer: producer).pluck(:thickness).uniq
    thickness_arr = thickness_by_producer.map { |thickness| thickness}
    # thickness_arr = RoofRailItem.thickness.values.map { |thickness| thickness if thickness.in?(thickness_by_producer) }

    # all coating by first thickness
    coating_by_thickness = RoofRailItem.where(slug: decking.slug).where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).pluck(:coating).uniq
    coating_arr = coating_by_thickness.map { |coating| coating }
    # coating_arr = RoofRailItem.coating.values.map { |coating| coating if coating.in?(coating_by_thickness) }

    # all lamina by first coating
    protective_lamina_by_coating = RoofRailItem.where(slug: decking.slug).where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).where(coating: coating_arr.select{|i| !i.nil? }[0]).pluck(:protective_lamina).uniq
    protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }
    # protective_lamina_arr = RoofRailItem.protective_lamina.values.map { |protective_lamina| protective_lamina if protective_lamina.in?(protective_lamina_by_coating) }

    # all colors by selected options
    test_item = RoofRailItem.where(slug: decking.slug).where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).where(coating: coating_arr.select{|i| !i.nil? }[0]).first
    colors_arr = test_item.rr_details.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }



    # json string with data
    if params_type == 'producer'
      product = RoofRailItem.find_by_producer(producer_by_item[0])
      current_producer = RoofRailItem.where(slug: decking.slug).where(producer: producer)

      # options to send
      options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_producer.first.id}.to_json


    elsif params_type == 'thickness'
      current_thickness = RoofRailItem.where(slug: product).where(producer: producer).where(thickness: thickness)
      coating_by_thickness = current_thickness.pluck(:coating).uniq
      coating_arr = coating_by_thickness.map { |coating| coating }

      protective_lamina_by_thickness = current_thickness.where(coating: coating_by_thickness[0]).pluck(:protective_lamina).uniq
      protective_lamina_arr = protective_lamina_by_thickness.map { |protective_lamina| protective_lamina }

      colors_arr = current_thickness.first.rr_details.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_thickness.first.id }.to_json


    elsif params_type == 'coating'
      current_el = RoofRailItem.where(slug: decking.slug).where(producer: producer).where(thickness: thickness).where(coating: coating)
      protective_lamina_by_coating = current_el.pluck(:protective_lamina).uniq
      protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }

      with_first_lamina = current_el.where(protective_lamina: protective_lamina_arr.first)
      colors_arr = with_first_lamina.first.rr_details.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_el.first.id }.to_json


    elsif params_type == 'lamina'
      current_lamina = RoofRailItem.where(slug: decking.slug).where(producer: producer).where(thickness: thickness).where(coating: coating).where(protective_lamina: lamina)
      colors_arr = current_lamina.first.rr_details.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {colors: colors_arr, product_id: current_lamina.first.id}.to_json


    else
      # options to send
      options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr }.to_json


    end



    respond_to do |format|
      format.json { render :json => options }
    end
  end





  def get_metal_tile_options

    product_key = params[:key]
    producer = params[:producer]
    thickness = params[:thickness]
    coating = params[:coating]
    lamina = params[:lamina]

    params_type = ''
    if producer && !thickness
      params_type = 'producer'
    elsif thickness && !coating
      params_type = 'thickness'
    elsif coating && !lamina
      params_type = 'coating'
    elsif lamina
      params_type = 'lamina'
    end

    # decking = RoofRailItem.find_by_slug(product)
    #
    # # all producers by product
    # producer_by_item = RoofRailItem.where(slug: decking.slug).pluck(:producer).uniq

    product = MetalTileDetail.find_by_slug(product_key)

    products = MetalTileDetail.where(slug: product.slug)

    # all producers by product
    producer_by_item = products.pluck(:producer).uniq

    # all thickness by producer
    thickness_by_producer = products.where(producer: producer).pluck(:thickness).uniq
    thickness_arr = thickness_by_producer.map { |thickness| thickness}

    # all coating by first thickness
    coating_by_thickness = products.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).pluck(:coating).uniq
    coating_arr = coating_by_thickness.map { |coating| coating }

    # all lamina by first coating
    protective_lamina_by_coating = products.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).where(coating: coating_arr.select{|i| !i.nil? }[0]).pluck(:protective_lamina).uniq
    protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }

    # all colors by selected options
    test_item = products.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).where(coating: coating_arr.select{|i| !i.nil? }[0]).first
    colors_arr = test_item.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

    # json string with data
    if params_type == 'producer'
      product_by_producer = MetalTileDetail.find_by_producer(producer_by_item[0])
      current_producer = products.where(producer: producer)

      # options to send
      options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_producer.first.id}.to_json

    elsif params_type == 'thickness'
      current_thickness = products.where(producer: producer).where(thickness: thickness)
      coating_by_thickness = current_thickness.pluck(:coating).uniq
      coating_arr = coating_by_thickness.map { |coating| coating }

      protective_lamina_by_thickness = current_thickness.where(coating: coating_by_thickness[0]).pluck(:protective_lamina).uniq
      protective_lamina_arr = protective_lamina_by_thickness.map { |protective_lamina| protective_lamina }

      colors_arr = current_thickness.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_thickness.first.id }.to_json

    elsif params_type == 'coating'
      current_el = products.where(producer: producer).where(thickness: thickness).where(coating: coating)
      protective_lamina_by_coating = current_el.pluck(:protective_lamina).uniq
      protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }

      with_first_lamina = current_el.where(protective_lamina: protective_lamina_arr.first)
      colors_arr = with_first_lamina.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_el.first.id }.to_json

    elsif params_type == 'lamina'
      current_lamina = products.where(producer: producer).where(thickness: thickness).where(coating: coating).where(protective_lamina: lamina)
      colors_arr = current_lamina.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {colors: colors_arr, product_id: current_lamina.first.id}.to_json

    else
      # options to send
      options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr }.to_json

    end

    respond_to do |format|
      format.json { render :json => options }
    end
  end

  def get_metal_sheet_options

    product_key = params[:key]
    producer = params[:producer]
    thickness = params[:thickness]
    coating = params[:coating]
    lamina = params[:lamina]

    params_type = ''
    if producer && !thickness
      params_type = 'producer'
    elsif thickness && !coating
      params_type = 'thickness'
    elsif coating && !lamina
      params_type = 'coating'
    elsif lamina
      params_type = 'lamina'
    end

    product = MetalSheetDetail.where(slug: product_key)

    # all producers by product
    producer_by_item = product.pluck(:producer).uniq

    # all thickness by producer
    thickness_by_producer = product.where(producer: producer).pluck(:thickness).uniq
    thickness_arr = thickness_by_producer.map { |thickness| thickness}

    # all coating by first thickness
    coating_by_thickness = product.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).pluck(:coating).uniq
    coating_arr = coating_by_thickness.map { |coating| coating }

    # all lamina by first coating
    protective_lamina_by_coating = product.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).where(coating: coating_arr.select{|i| !i.nil? }[0]).pluck(:protective_lamina).uniq
    protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }

    # all colors by selected options
    test_item = product.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).where(coating: coating_arr.select{|i| !i.nil? }[0]).first
    colors_arr = test_item.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }


    # json string with data
    if params_type == 'producer'
      product_by_producer = MetalSheetDetail.find_by_producer(producer_by_item[0])
      current_producer = product.where(producer: producer)

      # options to send
      options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_producer.first.id}.to_json

    elsif params_type == 'thickness'
      current_thickness = product.where(producer: producer).where(thickness: thickness)
      coating_by_thickness = current_thickness.pluck(:coating).uniq
      coating_arr = coating_by_thickness.map { |coating| coating }

      protective_lamina_by_thickness = current_thickness.where(coating: coating_by_thickness[0]).pluck(:protective_lamina).uniq
      protective_lamina_arr = protective_lamina_by_thickness.map { |protective_lamina| protective_lamina }

      colors_arr = current_thickness.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_thickness.first.id }.to_json

    elsif params_type == 'coating'
      current_el = product.where(producer: producer).where(thickness: thickness).where(coating: coating)
      protective_lamina_by_coating = current_el.pluck(:protective_lamina).uniq
      protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }

      with_first_lamina = current_el.where(protective_lamina: protective_lamina_arr.first)
      colors_arr = with_first_lamina.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_el.first.id }.to_json

    elsif params_type == 'lamina'
      current_lamina = product.where(producer: producer).where(thickness: thickness).where(coating: coating).where(protective_lamina: lamina)
      colors_arr = current_lamina.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {colors: colors_arr, product_id: current_lamina.first.id}.to_json

    else
      # options to send
      options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr }.to_json

    end

    respond_to do |format|
      format.json { render :json => options }
    end
  end


  def get_product_options

    product_key = params[:name]
    product_class = Object.const_get(params[:type]) rescue nil
    producer = params[:producer]
    thickness = params[:thickness]
    coating = params[:coating]
    lamina = params[:lamina]

    params_type = ''
    if producer && !thickness
      params_type = 'producer'
    elsif thickness && !coating
      params_type = 'thickness'
    elsif coating && !lamina
      params_type = 'coating'
    elsif lamina
      params_type = 'lamina'
    end

    product = product_class.where(slug: product_key)

    # all producers by product
    producer_by_item = product.pluck(:producer).uniq

    # all thickness by producer
    thickness_by_producer = product.where(producer: producer).pluck(:thickness).uniq
    thickness_arr = thickness_by_producer.map { |thickness| thickness}

    # all coating by first thickness
    coating_by_thickness = product.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).pluck(:coating).uniq
    coating_arr = coating_by_thickness.map { |coating| coating }

    # all lamina by first coating
    protective_lamina_by_coating = product.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).where(coating: coating_arr.select{|i| !i.nil? }[0]).pluck(:protective_lamina).uniq
    protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }

    # all colors by selected options
    test_item = product.where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).where(coating: coating_arr.select{|i| !i.nil? }[0]).first
    colors_arr = test_item.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }


    # json string with data
    if params_type == 'producer'
      product_by_producer = product_class.find_by_producer(producer_by_item[0])
      current_producer = product.where(producer: producer)

      # options to send
      options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_producer.first.id}.to_json

    elsif params_type == 'thickness'
      current_thickness = product.where(producer: producer).where(thickness: thickness)
      coating_by_thickness = current_thickness.pluck(:coating).uniq
      coating_arr = coating_by_thickness.map { |coating| coating }

      protective_lamina_by_thickness = current_thickness.where(coating: coating_by_thickness[0]).pluck(:protective_lamina).uniq
      protective_lamina_arr = protective_lamina_by_thickness.map { |protective_lamina| protective_lamina }

      colors_arr = current_thickness.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_thickness.first.id }.to_json

    elsif params_type == 'coating'
      current_el = product.where(producer: producer).where(thickness: thickness).where(coating: coating)
      protective_lamina_by_coating = current_el.pluck(:protective_lamina).uniq
      protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }

      with_first_lamina = current_el.where(protective_lamina: protective_lamina_arr.first)
      colors_arr = with_first_lamina.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {protective_lamina: protective_lamina_arr, colors: colors_arr, product_id: current_el.first.id }.to_json

    elsif params_type == 'lamina'
      current_lamina = product.where(producer: producer).where(thickness: thickness).where(coating: coating).where(protective_lamina: lamina)
      colors_arr = current_lamina.first.color_options.map {|color| {title: color.title, price: color.price, image: color.image.url(:thumb), image_large: color.image.url(:large)} }

      # options to send
      options = {colors: colors_arr, product_id: current_lamina.first.id}.to_json

    else
      # options to send
      options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr }.to_json

    end

    respond_to do |format|
      format.json { render :json => options }
    end
  end
end
