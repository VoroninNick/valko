class RoofRailingController < ApplicationController

  def index
    set_meta_tags title: 'Покрівлі та огорожі',
                  description: '',
                  keywords: ''
    @items = RoofRailItem.all
  end
  def decking
    @decking = RoofRailItem.find_by_slug(params[:title])
  end
end
