module MainHelper

  def promotions
    @promotions = Promotion.all
  end
  def static_data
    return data = StaticDatum.first
  end
end
