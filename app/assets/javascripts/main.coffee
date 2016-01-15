# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$(window).bind 'load', ->
#  footer = $('footer')
#  pos = footer.position()
#  height = $(window).height()
#  height = height - (pos.top)
#  height = height - footer.height()
#  if height > 0
#    footer.css 'margin-top': height + 'px'

windowsillCalculator = () ->
  $this = $(this)
  $wrap = $this.closest('.windowsill-calculator-wrap')
  $total_price = $wrap.find('.wp-price')

  count_element = $wrap.find('#count-windowsills').val()
  weight_element = $wrap.find(':selected').val()
  long_element = $wrap.find('#windowsill-long').val()/1000

#  console.log count_element
#  console.log weight_element
#  console.log long_element

  total_price = (long_element* weight_element)*count_element
  $total_price.text(total_price)
#    alert 'this value ='+count_element * weight_element


$ ->
#===================================================================
# countdown timer
#===================================================================
  countdown_timer = $('.valko-countdown-promo')
  countdown_timer.each ->
    ct_year = $(@).attr "data-year"
    ct_month = $(@).attr "data-month"
    ct_day = $(@).attr "data-day"
    $(@).countdown until: new Date(ct_year, ct_month, ct_day)

$(document).ready ->
#===================================================================
#  promotion banner
#===================================================================
  $("ul#promotion-banner").bxSlider
    auto: true,
    pause: 5000,
    controls: false,
    pagerCustom: ".promotion-banner-pager"
#===================================================================
#  windowsill photos carousel
#===================================================================
  $("ul#windowsill-images-carousel").bxSlider
    auto: false,
    pause: 5000,
    controls: false

#===================================================================
#  windowsill calculator
#===================================================================

  $('#count-windowsills').change ->
    windowsillCalculator.call(this)

  $('#windowsill-prices-option').change ->
    windowsillCalculator.call(this)

  $('input#windowsill-long').change ->
    windowsillCalculator.call(this)

#============================================================
# reveal modal
#============================================================

#  $('#offers-and-comments').foundation('reveal', 'open');