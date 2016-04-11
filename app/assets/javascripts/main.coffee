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

  console.log 'довжина', long_element
#  console.log 'weight',weight_element

  gag_price = 0
  if $('input#with_flap').is(':checked')
    console.log 'data-value', $('input#with_flap').attr('data-status')
    gag_price = parseInt($('input#with_flap').attr('data-status'))
    console.log('gag val', $('input#with_flap').attr('data-status'))

  else if $('input#on_the_edge').is(':checked')
    console.log 'edge'
    gag_price = parseInt($('input#on_the_edge').attr('data-status'))
  else if $('input#without_cap').is(':checked')
    gag_price = 0

  if $(@).hasClass('item-is-gag')
    total_price = count_element*parseInt($this.attr 'data-price')
    $total_price.text(Math.round(total_price))
    console.log 'item is gag' , $total_price
  else
    total_price = (long_element* weight_element)*count_element+gag_price
    $total_price.text(Math.round(total_price))


#===================================================================
# countdown timer
#===================================================================
$ ->
  countdown_timer = $('.valko-countdown-promo')
  countdown_timer.each ->
    ct_year = $(@).attr "data-year"
    ct_month = $(@).attr "data-month"
    ct_day = $(@).attr "data-day"
    $(@).countdown
      until: new Date(ct_year, parseInt(ct_month)-1, ct_day)

#  newYear = new Date
#  newYear = new Date(2016, 3, 1)
#  $('#defaultCountdown').countdown until: newYear


$(document).ready ->
#===================================================================
#  promotion banner
#===================================================================
  $("ul#promotion-banner").bxSlider
#    auto: true,
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

#  $('#share-modal').foundation('reveal', 'open');

#============================================================
# new windowsill
#============================================================
  $('#news-windowsill').owlCarousel
    items: 1
    dotsContainer: '#news-windowsill-dots'

#============================================================
# similar windowsill
#============================================================
  $('#similar-windowsill').owlCarousel
    items: 1
    dotsContainer: '#similar-windowsill-dots'

#============================================================
# recently viewed windowsill
#============================================================
  $('#recently-viewed-windowsill').owlCarousel
    items: 1
    dotsContainer: '#recently-viewed-windowsill-dots'

#============================================================
# similar gag
#============================================================
  $('#similar-gags').owlCarousel
    items: 1
    dotsContainer: '#similar-gag-dots'

#============================================================
# reveal modal
#============================================================
  $('#promotion-windowsill').owlCarousel
    items: 1
    dotsContainer: '#promotion-windowsill-dots'

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
    auto: true,
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
#  mobile list
#===================================================================
  $('.control-filters-mobile-button').click ->
    if $(@).closest('.control-filters').hasClass('cf-expanded')
      $(@).closest('.control-filters').removeClass('cf-expanded')
    else
      $(@).closest('.control-filters').addClass('cf-expanded')



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

#===========================================================
# callback handler for contact form submit
#===========================================================
  $('form.ajax-contact-form').submit (e) ->
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
#        console.log('перед відсиланням')
      success: ->
        form.reset()
#        console.log('успішно')
        $this.closest('form').find('.animate-input').each ->
#          if !$(@).hasClass('is-locked-for-clear')
          $(@).removeClass('is-completed')

        $this.closest('form').find('.field-to-hide').each ->
          $(@).addClass('hide')

        $('#success-contact-form').foundation 'reveal', 'open'
      complete: ->

      error: ->

    e.preventDefault()

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
        $('.cart-link').addClass('animated bounceIn')
      success: (data) ->

        console.log 'test'

        form.reset()
        if $this.closest('.call-order-wrap')
          $this.closest('.call-order-wrap').removeClass('opened')

#        console.log('успішно')
        if parseInt(data) > 0
          $('.cart-link').addClass('cart-not-empty')
          $('.cl-count-items .cl-ci-number').text(data)

        $('#SuccessModal').foundation 'reveal', 'open'
        
      complete: ->
        setTimeout (->
          $('.cart-link').removeClass('animated bounceIn')
        ), 600

      error: ->

    e.preventDefault()

#===========================================================
# promotion banner title click
#===========================================================
  $('.promotion-banner-pager .title').click ->
    location.href = $(@).closest('a').attr('href')

#===========================================================
# windowsill gag
#===========================================================
  $('.control-filter').click ->
    gag_list = $('#gag-list')
    windowsill_list = $('#windowsill-list')

    if $(@).hasClass('gag-filter')
      if gag_list.hasClass('hide')
        gag_list.removeClass('hide')
        windowsill_list.addClass('hide')
      else
        gag_list.addClass('hide')
        windowsill_list.removeClass('hide')

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

    rez = parseInt($total_price.text()) - parseInt($item_price.text())
#    console.log 'rez:', rez

    $.ajax
      url: action_path
      type: 'post'
#      data: {_method: 'delete', _token :token},
      data: {_method: 'delete'}
      success: ->
        $total_price.text(rez)
        $item.addClass('deleting-line-item')
        setTimeout (->
            $item.remove()
          ), 600

    e.preventDefault()

#===========================================================
# update quantity items
#===========================================================
  $('.basket-count-product input').change ->
    $this = $(@)
    $wrap = $this.closest('.basket-wrap')
    $total_price = $wrap.find('.basket-total-price b')
    $item = $this.closest('.basket-list-one')

#    one item total price
    $item_total_price = $item.find('.one-total-price b')
    console.log 'one item total price'

    default_total_price = parseInt($this.attr 'data-total-price')
    start_quantity = parseInt($this.attr 'data-old-value')

#   one item price
    item_price = parseInt($item.find('.one-price b').text())
    new_item_price = $item.attr('data-item-price')
    console.log 'one item price', new_item_price

    console.log 'default_total_price total price', default_total_price
    total_price = default_total_price - start_quantity * item_price

    console.log 'total price after update', total_price
#    console.log 'total price old:', total_price
#    console.log 'total price new:', total_price + parseInt(@value*item_price)

    gag_edge = $item.attr('data-gag-edge')
    console.log 'gag edge price', gag_edge

#    $item_total_price.text(parseInt(@value*item_price)+gag_edge*$this.val())
    console.log 'item price', @value*item_price

    new_item_total_price = (parseInt(new_item_price)+parseInt(gag_edge))*$this.val()

    $item_total_price.text(new_item_total_price)
    console.log 'new version price', new_item_total_price
#    >
    $total_price.text(total_price + parseInt(@value*item_price)+gag_edge*$this.val())

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

    if parseInt($this.val()) > 0
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
          console.log 'updated'
  #          loadPartials()
  #          alert 'succes'
        error: (err) ->
          alert "Error"


#===========================================================
# cart states
#===========================================================
  $('.cart-button a').click ->
    $this = $(@)
    $wrap = $this.closest('.basket-wrap')
    go_to = $this.attr('data-step')

    count_items = $wrap.find('.basket-list-one').size()

    first_name = $wrap.find('input[name="first_name"]').val()
    last_name = $wrap.find('input[name="last_name"]').val()
    phone_number = $wrap.find('input[name="phone"]').val()
    email = $wrap.find('input[name="email"]').val()
    message = $wrap.find('textarea[name="message"]').val()
    shipping = $wrap.find('option:selected').val()

    if $this.hasClass('first-step')
      if count_items > 0
        $('.cart-tab').removeClass('active')
        $(".cart-tab.#{go_to}").addClass('active')


    else if $this.hasClass('finish-step')
#      console.log 'finish step'
      console.log 'values:'+ first_name + last_name + phone_number + email + message + shipping

      action_path = $this.attr('data-href')
      cart_id = $wrap.attr('data-cart')

      DataToSend =
        first_name: first_name
        last_name: last_name
        phone_number: phone_number
        email: email
        message: message
        shipping: shipping
        cart_id: cart_id

      #Call jQuery ajax
      $.ajax
        url: action_path
        dataType: 'html'
        type: "POST"
        data: DataToSend
        before: ->
        success: (msg) ->
          console.log "products ordered"
          $.ajax
            url: $this.attr('data-action')
            dataType: "json"
            type: "DELETE"
            before: ->
            success: (msg) ->
              $('#ordered-products').foundation('reveal', 'open');
            error: (err) ->
        error: (err) ->

    else
      if go_to == 'cart-confirmation'
        $confirm_form =$this.closest('.cart-tab').find('form')
        $confirm_form.submit()

        valid_status = $('#basket-contacts-info input:invalid').length
        if valid_status > 0
          console.log 'invalid'
        else
          $('.cart-tab').removeClass('active')
          $(".cart-tab.#{go_to}").addClass('active')
          console.log 'values:'+ first_name + last_name + phone_number + email + message + shipping

          $('.bc-ci-value.bcv-first-name p').text(first_name)
          $('.bc-ci-value.bcv-last-name p').text(last_name)
          $('.bc-ci-value.bcv-phone p').text(phone_number)
          $('.bc-ci-value.bcv-email p').text(email)
          $('.bc-ci-value.bcv-message p').text(message)
          $('.bc-ci-value.bcv-shipping p').text(shipping)

          $.get( $this.attr('data-action'), ->
#            alert 'success'
          )
      else
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
  #windowsill
  if localStorage.getItem("catalog-header-status") == 'hiden'
    $('.windowsill-catalog-list-header').addClass('hiden-catalog-header')
    if $('.hch-arrow.valko-arrow').hasClass('va-top')
      $('.hch-arrow.valko-arrow').removeClass('va-top')
      $('.hch-arrow.valko-arrow').addClass('va-bottom')
      $('.hide-catalog-header .title').text('Розгорнути')
    else
      $('.hch-arrow.valko-arrow').removeClass('va-bottom')
      $('.hch-arrow.valko-arrow').addClass('va-top')
      $('.hide-catalog-header .title').text('Згорнути')

  #roof rail
#  if localStorage.getItem("rr-catalog-header-status") == 'hiden'
#    $('.roof-rail-catalog-list-header').addClass('hiden-catalog-header')
#    if $('.hch-arrow.valko-arrow').hasClass('va-top')
#      $('.hch-arrow.valko-arrow').removeClass('va-top')
#      $('.hch-arrow.valko-arrow').addClass('va-bottom')
#      $('.hide-catalog-header .title').text('Розгорнути')
#    else
#      $('.hch-arrow.valko-arrow').removeClass('va-bottom')
#      $('.hch-arrow.valko-arrow').addClass('va-top')
#      $('.hide-catalog-header .title').text('Згорнути')


  $('.hide-catalog-header').click ->
    $this = $(@)
    $wrap = $this.closest('.main-body')

    if $this.hasClass('is-rr-catalog')
#      $obj = $wrap.find('.roof-rail-catalog-list-header')
#      if $obj.hasClass('hiden-catalog-header')
#        $obj.removeClass('hiden-catalog-header')
#        localStorage.setItem("rr-catalog-header-status", "open")
#
#        if $('.hch-arrow.valko-arrow').hasClass('va-top')
#          $('.hch-arrow.valko-arrow').removeClass('va-top')
#          $('.hch-arrow.valko-arrow').addClass('va-bottom')
#          $('.hide-catalog-header .title').text('Розгорнути')
#        else
#          $('.hch-arrow.valko-arrow').removeClass('va-bottom')
#          $('.hch-arrow.valko-arrow').addClass('va-top')
#          $('.hide-catalog-header .title').text('Згорнути')
#
#      else
#        $obj.addClass('hiden-catalog-header')
#        localStorage.setItem("rr-catalog-header-status", "hiden")
#        $('.hide-catalog-header .title').text('Розгорнути')
#
#        if $('.hch-arrow.valko-arrow').hasClass('va-top')
#          $('.hch-arrow.valko-arrow').removeClass('va-top')
#          $('.hch-arrow.valko-arrow').addClass('va-bottom')
#          $('.hide-catalog-header .title').text('Розгорнути')
#        else
#          $('.hch-arrow.valko-arrow').removeClass('va-bottom')
#          $('.hch-arrow.valko-arrow').addClass('va-top')
#          $('.hide-catalog-header .title').text('Згорнути')
    else
      $obj = $wrap.find('.windowsill-catalog-list-header')
      if $obj.hasClass('hiden-catalog-header')
        $obj.removeClass('hiden-catalog-header')
  #      $.session.set("catalog-header-status", "open")
        localStorage.setItem("catalog-header-status", "open")

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
  #      $.session.set("catalog-header-status", "hiden")
        localStorage.setItem("catalog-header-status", "hiden")
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

#===========================================================
# contacts form
#===========================================================
  $('input#or_person_is_wholesale_buyer').change ->
    n = $( "input#or_person_is_wholesale_buyer:checked" ).length
    $this = $(@)
    $wrap = $this.closest('.feedback-form')

    if n < 1
      console.log '0'
      $wrap.find('.field-to-hide').addClass('hide')
    else
      console.log '1'
      $wrap.find('.field-to-hide').removeClass('hide')
#    console.log 'checkbox status:', n

#===========================================================
# catalog filters switcher
#===========================================================
  $(".windowsill-cf-radio input[type='radio']").change ->
    $this = $(@)
    $wrap = $this.closest('.control-filters')
    $('.control-filter').removeClass('expanded')
    $(".control-filter input[type='checkbox']").attr('checked', false)

    if $this.val() == 'internal'
      $wrap.find('.control-filter').hide()
      $wrap.find('.control-filter').filter('.internal').show()
    else if $this.val() == 'external'
      $wrap.find('.control-filter').hide()
      $wrap.find('.control-filter').filter('.external').show()
    else if $this.val() == 'gag'
      $wrap.find('.control-filter').hide()

#===========================================================
# copy to clipboard
#===========================================================
  clipboard = new Clipboard('.copy-btn')
  clipboard.on 'success', (e) ->
    console.log e

$(window).scroll ->
  console.log 'scroll top:', $(document).scrollTop()
  if $(document).scrollTop() >= 215
    $('.cart-link').addClass('fixed-cart')
#    cart_ot = $('.cart-link').offset().top
#  console.log 'test', cart_ot
  else
    if $('.cart-link').hasClass('fixed-cart')
      $('.cart-link').removeClass('fixed-cart')