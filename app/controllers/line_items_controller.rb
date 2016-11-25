class LineItemsController < ApplicationController
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    # @line_item = LineItem.new(line_item_params)

    type = params[:type]
    windowsill_id = params[:id]
    quantity = params[:quantity]
    weight = params[:weight]
    long = params[:long]
    options = params[:windowsill_option]
    option_return = false
    option_edge = false
    option_nonstandard = false
    if options == 'with_gag'
      option_return = true
    elsif options == 'with_edge'
      option_edge = true
    elsif options == 'nonstandard'
      option_nonstandard = true
    end

    if type == 'Windowsill'
      windowsill = Windowsill.find(windowsill_id)
      #
      existed_item = @cart.line_items.where(:windowsill_id => windowsill_id, :weight => weight, :long => long, :with_gag => option_return, :with_edge => option_edge, :nonstandard => option_nonstandard )

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        if options == 'with_gag'
          @line_item = @cart.line_items.build(windowsill: windowsill, quantity: quantity, weight: weight, long: long, class_name: type, with_gag: true, with_edge: false, nonstandard: false)
        elsif options == 'with_edge'
          @line_item = @cart.line_items.build(windowsill: windowsill, quantity: quantity, weight: weight, long: long, class_name: type, with_gag: false, with_edge: true, nonstandard: false)
        elsif options == 'nonstandard'
          @line_item = @cart.line_items.build(windowsill: windowsill, quantity: quantity, weight: weight, long: long, class_name: type, with_gag: false, with_edge: false, nonstandard: true)
        else
          @line_item = @cart.line_items.build(windowsill: windowsill, quantity: quantity, weight: weight, long: long, class_name: type, with_gag: false, with_edge: false, nonstandard: false)
          test = 'e'
        end
      end

    elsif type == 'Gag'
      gag = Gag.find(params[:id])
      existed_item = @cart.line_items.where(:gag_id => params[:id])

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(gag: gag, quantity: quantity, class_name: type)
      end

    elsif type == 'Decking'
      color = params[:catalog_rr_color]
      decking = RoofRailItem.find(params[:id])

      existed_item = @cart.line_items.where(roof_rail_item_id: params[:id], long: long, quantity: quantity, class_name: type, color: color)

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(roof_rail_item_id: params[:id], long: long, quantity: quantity, class_name: type, color: color)
      end

    elsif type == 'Mosquito'
      # product = MosquitoItem.find(params[:id])
      existed_item = @cart.line_items.where(mosquito_item_id: params[:id], weight: params[:height], long: params[:width], quantity: params[:quantity], mosquito_item_option_id: params[:option_product_id], product_options: params[:product_options])
      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(mosquito_item_id: params[:id], weight: params[:height], long: params[:width], quantity: params[:quantity], mosquito_item_option_id: params[:option_product_id], product_options: params[:product_options], class_name: type)
      end

    # MetalTile
    elsif type == 'MetalTile'
      color = params[:catalog_rr_color]
      decking = MetalTileDetail.find(params[:id])

      existed_item = @cart.line_items.where(metal_tile_detail_id: params[:id], long: long, quantity: quantity, class_name: type, color: color)

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(metal_tile_detail_id: params[:id], long: long, quantity: quantity, class_name: type, color: color)
      end



    # MetalSheet
    elsif type == 'MetalSheet'
      color = params[:catalog_rr_color]
      decking = MetalSheetDetail.find(params[:id])

      existed_item = @cart.line_items.where(metal_sheet_detail_id: params[:id], long: long, quantity: quantity, class_name: type, color: color)

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(metal_sheet_detail_id: params[:id], long: long, quantity: quantity, class_name: type, color: color)
      end


    # ChoicestItem
    elsif type == 'ChoicestItem'
      color = params[:catalog_rr_color]
      item = ChoicestItemDetail.find(params[:id])

      existed_item = @cart.line_items.where(choicest_item_detail_id: params[:id], quantity: quantity, class_name: type, color: color)

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(choicest_item_detail_id: params[:id], quantity: quantity, class_name: type, color: color)
      end

    # Sealant
    elsif type == 'Sealant'
      # color = params[:catalog_rr_color]
      item = Sealant.find(params[:id])

      existed_item = @cart.line_items.where(sealant_id: params[:id], class_name: type)

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(sealant_id: params[:id], quantity: quantity, class_name: type)
      end

    # Fastener
    elsif type == 'Fastener'
      color = params[:catalog_rr_color]
      item = FastenerOption.find(params[:id])

      existed_item = @cart.line_items.where(fastener_option_id: params[:id], class_name: type, color: color)

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(fastener_option_id: params[:id], quantity: quantity, class_name: type, color: color)
      end

    # Membrane
    elsif type == 'Membrane'
      item = Membrane.find(params[:id])

      existed_item = @cart.line_items.where(membrane_id: params[:id], class_name: type)

      if existed_item.count > 0
        @line_item = existed_item.first
        if @line_item && !@line_item.quantity
          @line_item.quantity = 0
        end
        @line_item.increase_quantity(quantity)
      else
        @line_item = @cart.line_items.build(membrane_id: params[:id], quantity: quantity, class_name: type)
      end

    end




    respond_to do |format|
      if @line_item.save
        # format.html { redirect_to @line_item, notice: 'Line item was successfully created.' }
        count_li = @line_item.cart.total_quantity
        format.json { render json: count_li , status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:windowsill_id, :quantity, :type, :with_gag, :with_edge, :weight, :long, :roof_rail_item_id, :color, :nonstandard, :mosquito_item, )
    end
end
