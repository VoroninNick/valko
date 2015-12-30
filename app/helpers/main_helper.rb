module MainHelper

  def promotions
    @promotions = Promotion.all
  end
end
