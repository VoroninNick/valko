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
  weight_element = $wrap.find(':selected').attr('data-value')
  long_element = $wrap.find('#windowsill-long').val()/1000

#  console.log count_element
  console.log 'weight',weight_element
#  console.log long_element
  gag_price = 0
  if $('input#with_flap').is(':checked')
    console.log 'data-value', $('input#with_flap').attr('data-status')
    gag_price = parseInt($('input#with_flap').attr('data-status'))
    console.log('gag val', $('input#with_flap').attr('data-status'))
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
    auto: false
    pause: 5000
    controls: false
    infiniteLoop: false

#===================================================================
#  windowsill calculator
#===================================================================

  $('#count-windowsills').change ->
    windowsillCalculator.call(this)

  $('#weight').change ->
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
# recently viewed windowsill
#============================================================
  $('#recently-viewed-windowsill').owlCarousel
#    loop: true
    margin: 30
    dotsContainer: '#recently-viewed-windowsill-dots'
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
#  photo - video gallery
#===================================================================
  gallery = null

  #  apartment light gallery
  $('ul#windowsill-images-carousel li').click ->
    $this = $(@)
    $wrap = $this.closest('ul')
    slides = $wrap.find('li')

    cii = $this.index()
    elmenetsListData = $.map($wrap.find('li'), (el) ->
      {
      src: $(el).attr 'data-gallery-src'
      thumb: $(el).attr 'data-gallery-thumb'
      }
    )
    console.log("cii", cii)
    $gallery = $('#lightgallery')
    $gallery.lightGallery
      dynamic: true
      dynamicEl: elmenetsListData
      index: cii

    gallery ?= $gallery.data("lightGallery")
    gallery.index = cii
    console.log("gallery", gallery)
    window.gallery = gallery

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

#===========================================================
#callback handler for form submit
#===========================================================
#  $('form.ajax-popup-form').submit (e) ->
#    $this = $(@)
#    postData = $this.serializeArray()
#    formURL = $this.attr('action')
#    form = this
#
#    $.ajax
#      url: formURL
#      dataType: 'html'
#      type: "POST"
#      data: postData
#      beforeSend: ->
#        console.log('перед відсиланням')
#      success: ->
#        form.reset()
#        if $this.closest('.call-order-wrap')
#          $this.closest('.call-order-wrap').removeClass('opened')
#
#        console.log('успішно')
#        #        $this.closest('form').find('.animate-input').each ->
#        #          if !$(@).hasClass('is-locked-for-clear')
#        #            $(@).removeClass('is-completed')
#        #
#        $('#SuccessModal').foundation 'reveal', 'open'
#      complete: ->
#
#      error: ->
#
#    e.preventDefault()

#===========================================================
#  main-menu binder
#===========================================================
  $("a.navicon-button").click ->
    $this = $(@)
    $wrap = $this.closest('body')
    if $wrap.hasClass('opened-mobile-menu')
      $wrap.removeClass('opened-mobile-menu')
    else
      $wrap.addClass('opened-mobile-menu')

    if $this.hasClass('open')
      $this.removeClass('open')
    else
      $this.addClass('open')

#===========================================================
# add product to curt
#===========================================================
  $('form.ajax-popup-form').submit (e) ->
    $this = $(@)
    postData = $this.serializeArray()
    formURL = $this.attr('action')
    form = this

    $.ajax
      url: formURL
      dataType: 'html'
      type: "POST"
      data: postData
      beforeSend: ->
        console.log('перед відсиланням')
        $('.cart-link').addClass('animated swing')
      success: ->
        form.reset()
        if $this.closest('.call-order-wrap')
          $this.closest('.call-order-wrap').removeClass('opened')

        console.log('успішно')

        #        $this.closest('form').find('.animate-input').each ->
        #          if !$(@).hasClass('is-locked-for-clear')
        #            $(@).removeClass('is-completed')
        #
        $('#SuccessModal').foundation 'reveal', 'open'
      complete: ->
        $('.cart-link').removeClass('animated swing')
      error: ->

    e.preventDefault()

#===========================================================
# delete line item from cart
#===========================================================
  $('a.delete-item').click (e)->
    $this = $(@)
    $wrap = $this.closest('.basket-wrap')
    $total_price = $wrap.find('.basket-total-price b')
    $item = $this.closest('.basket-list-one')
    $item_price = $item.find('.one-total-price')

    action_path = $this.attr('data-href')+'/'+$this.attr('data-line-item-id')

    token = $(this).data('token')

#    console.log 'item price:', $item_price.text()
#    console.log 'total price:', parseInt($total_price.text()
    rez = parseInt($total_price.text()) - parseInt($item_price.text())
    console.log 'rez:', rez
    $.ajax
      url: action_path
      type: 'post'
#      data: {_method: 'delete', _token :token},
      data: {_method: 'delete'}
      success: ->
        $total_price.text(rez)
        $item.remove()

    e.preventDefault()

#===========================================================
# update quantity items
#===========================================================
  $('.basket-count-product input').change ->
    $this = $(@)
    $wrap = $this.closest('.basket-wrap')
    $total_price = $wrap.find('.basket-total-price b')
    $item = $this.closest('.basket-list-one')
    $item_total_price = $item.find('.one-total-price b')

    default_total_price = parseInt($this.attr 'data-total-price')
    start_quantity = parseInt($this.attr 'data-old-value')
    item_price = parseInt($item.find('.one-price b').text())

    total_price = default_total_price - start_quantity * item_price

#    console.log 'total price old:', total_price
#    console.log 'total price new:', total_price + parseInt(@value*item_price)
    $item_total_price.text(parseInt(@value*item_price))
    $total_price.text(total_price + parseInt(@value*item_price))

#    console.log 'quantity:', @value

    $product_id = $this.attr 'data-product-id'
    $weight = $this.attr 'data-weight'
    $long = $this.attr 'data-long'
    $type_product = $this.attr 'data-type'
    $gag = $this.attr 'data-gag'

    console.log 'product id:', $product_id, 'weight:', $weight, 'long:', $long, 'type:', $type_product, 'gag:', $gag, 'value:', parseInt($this.val())
    action_path = $this.attr('data-href')+'/'+$this.attr('data-line-item-id')

    DataToSend =
      product_id: $product_id
      quantity: parseInt($this.val())
      weight: $weight
      long: $long
      class_name: $type_product
      with_gag: $gag

    #Call jQuery ajax
    $.ajax
      type: "PUT"
      contentType: "application/json; charset=utf-8"
      url: action_path
      data: JSON.stringify(DataToSend)
      dataType: "json"
      before: ->
#          alert 'before'
      success: (msg) ->

#          loadPartials()
#          alert 'succes'
      error: (err) ->
        alert "Error"


#===========================================================
# cart states
#===========================================================
  $('.cart-button a').click ->
    $this = $(@)
    $wrap = $this.closest('.cart-tab')
    go_to = $this.attr('data-step')

#    console.log 'attribute:',go_to
    $('.cart-tab').removeClass('active')
    $(".cart-tab.#{go_to}").addClass('active')



#===========================================================
# page up
#===========================================================
  $('.scroll-top-button').click ->
    $("html, body").animate
      scrollTop: 0
    , 800
    false

#===========================================================
# catalog hiden header
#===========================================================

  if $.session.get("catalog-header-status") == 'hiden'
    $('.windowsill-catalog-list-header').addClass('hiden-catalog-header')
    if $('.hch-arrow.valko-arrow').hasClass('va-top')
      $('.hch-arrow.valko-arrow').removeClass('va-top')
      $('.hch-arrow.valko-arrow').addClass('va-bottom')
      $('.hide-catalog-header .title').text('Розгорнути')
    else
      $('.hch-arrow.valko-arrow').removeClass('va-bottom')
      $('.hch-arrow.valko-arrow').addClass('va-top')
      $('.hide-catalog-header .title').text('Згорнути')


  $('.hide-catalog-header').click ->
    $this = $(@)
    $wrap = $this.closest('.main-body')
    $obj = $wrap.find('.windowsill-catalog-list-header')
    if $obj.hasClass('hiden-catalog-header')
      $obj.removeClass('hiden-catalog-header')
      $.session.set("catalog-header-status", "open")

      if $('.hch-arrow.valko-arrow').hasClass('va-top')
        $('.hch-arrow.valko-arrow').removeClass('va-top')
        $('.hch-arrow.valko-arrow').addClass('va-bottom')
        $('.hide-catalog-header .title').text('Розгорнути')
      else
        $('.hch-arrow.valko-arrow').removeClass('va-bottom')
        $('.hch-arrow.valko-arrow').addClass('va-top')
        $('.hide-catalog-header .title').text('Згорнути')

    else
      $obj.addClass('hiden-catalog-header')
      $.session.set("catalog-header-status", "hiden")
      $('.hide-catalog-header .title').text('Розгорнути')

      if $('.hch-arrow.valko-arrow').hasClass('va-top')
        $('.hch-arrow.valko-arrow').removeClass('va-top')
        $('.hch-arrow.valko-arrow').addClass('va-bottom')
        $('.hide-catalog-header .title').text('Розгорнути')
      else
        $('.hch-arrow.valko-arrow').removeClass('va-bottom')
        $('.hch-arrow.valko-arrow').addClass('va-top')
        $('.hide-catalog-header .title').text('Згорнути')

#===========================================================
# catalog list order
#===========================================================
  $('body').on "click",".sorted-control", ->
    $this = $(@)

    if $this.hasClass('sby-date')
      if $this.hasClass('sc-desc')
        $('.wclb-header option').removeAttr('selected').filter('[value=created_at_asc]').attr('selected', true).change()
        $this.removeClass('sc-desc')
        $this.addClass('sc-asc')

      else if $this.hasClass('sc-asc')
        $('.wclb-header option').removeAttr('selected').filter('[value=created_at_desc]').attr('selected', true).change()
        $this.removeClass('sc-asc')
        $this.addClass('sc-desc')
      else
        $('.wclb-header option').removeAttr('selected').filter('[value=created_at_asc]').attr('selected', true).change()
        $('.sorted-control.sby-name').removeClass('sc-asc sc-desc')
        $this.addClass('sc-asc')


    else if $this.hasClass('sby-name')
      if $this.hasClass('sc-desc')
        $('.wclb-header option').removeAttr('selected').filter('[value=title_asc]').attr('selected', true).change()
        $this.removeClass('sc-desc')
        $this.addClass('sc-asc')

      else if $this.hasClass('sc-asc')
        $('.wclb-header option').removeAttr('selected').filter('[value=title_desc]').attr('selected', true).change()
        $this.removeClass('sc-asc')
        $this.addClass('sc-desc')

      else
        $('.wclb-header option').removeAttr('selected').filter('[value=title_asc]').attr('selected', true).change()
        $('.sorted-control.sby-date').removeClass('sc-asc sc-desc')
        $this.addClass('sc-asc')


#    $('.wclb-header option[value=created_at_asc]')
#    $('.wclb-header option[value=created_at_desc]')
#    $('.wclb-header option[value=title_asc]')
#    $('.wclb-header option[value=title_desc]')


