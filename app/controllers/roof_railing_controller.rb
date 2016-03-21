class RoofRailingController < ApplicationController

  def index
    set_meta_tags title: 'Покрівлі та огорожі',
                  description: '',
                  keywords: ''
    @item = RoofRailItem.first
  end
  def decking
    @decking = RoofRailItem.find_by_slug(params[:title])
  end
  def get_rr_options
    received_key = params[:key]
    producer = received_key.partition('-').first
    product = received_key.partition('-').last

    decking = RoofRailItem.find_by_slug(product)

    # all producers by product
    producer_by_item = RoofRailItem.where(slug: product).pluck(:producer).uniq

    # all thickness by producer
    thickness_by_producer = RoofRailItem.where(slug: product).where(producer: producer).pluck(:thickness).uniq
    thickness_arr = thickness_by_producer.map { |thickness| thickness}
    # thickness_arr = RoofRailItem.thickness.values.map { |thickness| thickness if thickness.in?(thickness_by_producer) }

    # all coating by first thickness
    coating_by_thickness = RoofRailItem.where(slug: product).where(producer: producer).where(thickness: thickness_arr.select{|i| !i.nil? }[0]).pluck(:coating).uniq
    coating_arr = coating_by_thickness.map { |coating| coating }
    # coating_arr = RoofRailItem.coating.values.map { |coating| coating if coating.in?(coating_by_thickness) }

    # all lamina by first coating
    protective_lamina_by_coating = RoofRailItem.where(slug: product).where(producer: producer).where(thickness: thickness_arr[0]).where(coating: coating_arr[0]).pluck(:protective_lamina).uniq
    protective_lamina_arr = protective_lamina_by_coating.map { |protective_lamina| protective_lamina }
    # protective_lamina_arr = RoofRailItem.protective_lamina.values.map { |protective_lamina| protective_lamina if protective_lamina.in?(protective_lamina_by_coating) }

    # all colors by selected options
    test_item = RoofRailItem.where(slug: product).where(producer: producer).where(thickness: thickness_arr[0]).where(coating: coating_arr[0]).first
    colors_arr = test_item.rr_details.map {|color| color.title}

    # json string with data
    options = {thickness: thickness_arr, coating: coating_arr, protective_lamina: protective_lamina_arr, colors: colors_arr }.to_json

    respond_to do |format|
      format.json { render :json => options }
    end
  end
end
