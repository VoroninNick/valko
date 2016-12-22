module MainHelper

  def promotions
    @promotions = Promotion.published
  end
  def static_data
    return data = StaticDatum.first
  end
end
