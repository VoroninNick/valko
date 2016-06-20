# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

DefaultProductCalculator = () ->
  $this = $(this)
  $wrap = $this.closest('.default-calculator-wrap')
  $total_price = $wrap.find('.rrp-price')
  $calculator_instrunction = $('.calculator-instruction')

  width_prod = parseFloat($('#calculator-width').val())/1000
  console.log "product width: ", width_prod
  height_prod = parseFloat($('#calculator-height').val())/1000
  console.log "product height: ", height_prod
  price_prod = parseFloat($calculator_instrunction.attr('data-price'))
  console.log "product price: ", price_prod
  quantity_prod = parseInt($('#calculator-quantity').val())
  console.log "quantity width: ", quantity_prod

  total_price = 0

  if $calculator_instrunction.hasClass('mosquito-calc')
    condition_prod = parseFloat($calculator_instrunction.attr('data-condition'))
    square_prod = width_prod * height_prod
    if square_prod < condition_prod
      total_price = (price_prod * quantity_prod) * condition_prod
    else
      total_price = (price_prod * quantity_prod) * square_prod
  else
    alert 'product dosnt mosquito grid'

  $total_price.text(Math.round(total_price))


$(document).ready ->
#===================================================================
#  mosquito grid banner
#===================================================================
  $("ul#mosquito-grid-banner").bxSlider
    auto: false,
    pause: 5000,
    controls: false


#===================================================================
#  default calculator
#===================================================================
  $('.default-calculator-wrap input[type="number"]').change ->
    console.log 'Calculator woking!'
    DefaultProductCalculator.call(this)

#===================================================================
#  mosquito grid change color and photo with price
#===================================================================
  $('body').on "change",".catalog-rr-one-color.is-mosquito-grid.enable-catalog-element input[type='radio']", ->
    $this = $(@)
    $wrap = $this.closest('.catalog-one-item-page')
    $image = $wrap.find('.coi-photo .image')


    image_link = $(@).closest('.catalog-rr-one-color').attr "data-image"
    image_large_link = $(@).closest('.catalog-rr-one-color').attr "data-img-large"
    price = $(@).closest('.catalog-rr-one-color').attr "data-price"

    console.log 'this price!!!!!!!!!!!!!!!!!!!!!!!', price
    $wrap.find('input[name="price"]').val(price)
    $image.css 'background-image', 'url(' + image_link + ')'
    console.log 'large image :', image_large_link

    $image.parent().attr 'href', image_large_link

    DefaultProductCalculator.call(this)