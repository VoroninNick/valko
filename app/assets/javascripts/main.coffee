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
  gag_price = 0
  if $('input#with_flap').is(':checked')
    gag_price = parseInt($(@).val())
    console.log('gag val', $(@).val())
#    alert '1'
  else if $('input#without_cap').is(':checked')
    gag_price = 0
#    alert '2'
  console.log gag_price
  total_price = (long_element* weight_element)*count_element+gag_price
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
  $(".cr-wrap input[type='radio']").change ->
    windowsillCalculator.call(this)

#============================================================
# reveal modal
#============================================================

#  $('#offers-and-comments').foundation('reveal', 'open');

#============================================================
# reveal modal
#============================================================
  $('#news-windowsill').owlCarousel
#    loop: true
    margin: 30
#    nav: true
  #  navContainer: '#customNav'
    dotsContainer: '#news-windowsill-dots'
    responsive:
      0: items: 2
      600: items: 3
      1000: items: 4

#============================================================
# reveal modal
#============================================================
  $('#promotion-windowsill').owlCarousel
#    loop: true
    margin: 30
    dotsContainer: '#promotion-windowsill-dots'
    responsive:
      0: items: 2
      600: items: 3
      1000: items: 4

#============================================================
# reveal modal
#============================================================
  $('input:radio[name="windowsill_option"]').change ->
    $this = $(@)
    $wrap = $this.closest('.windowsill-calculator-wrap')
    $mb = $wrap.find('.attention-message')
    $mb.hide()

    if $this.attr("id") == "customised" && $this.is(':checked')
      $mb.show()

#============================================================
# catalog windowsill
#============================================================
  $('.control-filter').click ->
    $(@).toggleClass('expanded')

#===================================================================
#  about us banner
#===================================================================
  $("ul#about-us-banner").bxSlider
    auto: false,
    pause: 5000,
    controls: false

#    console.log $.session.get('main#windowsill')

#===================================================================
#  photo - video gallery
#===================================================================
#  $("#windowsill-images-carousel").lightSlider()
  $('.lightGallery').lightGallery ->
    thumbnail:true

#===================================================================
#  json parser
#===================================================================
#  myData = []
#  $.ajax
#    url: 'http://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?valcode=EUR&date=20160127&json'
#    data: myData
#    type: 'GET'
#    crossDomain: true
#    dataType: 'jsonp'
#    success: ->
#      alert 'Success'
#
#    error: ->
#      alert 'Failed!'

#  $.getJSON 'http://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?valcode=EUR&date=20160127&json', (data) ->
#    items = []
#    $.each data, (key, val) ->
#      items.push '<li id=\'' + key + '\'>' + val + '</li>'
#    alert 't'
#    $('<ul/>',
#      'class': 'my-new-list'
#      html: items.join('')).appendTo 'body'




