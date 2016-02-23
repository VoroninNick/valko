module ApplicationHelper
  include CurrentCart

  def cp(path)
    "current" if current_page?(path)
  end

  def windowsill_list_id
    # windowsill_ids = session[:recently_viewed].split(",").map(&:to_i).map(&:to_i)
    windowsill_ids = session[:recently_viewed].split(",") if session[:recently_viewed]
  end
  def recently_viewed
    if windowsill_list_id && windowsill_list_id.any?
      @recently_viewed = Windowsill.find(*windowsill_list_id) || []
      @recently_viewed = [@recently_viewed] if @recently_viewed && !@recently_viewed.respond_to?(:any?)
    else
      @recently_viewed = []
    end

    @recently_viewed
  end

  def current_cart
    set_cart
  end
end
