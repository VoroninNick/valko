# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

deckingCalculator = () ->
  $this = $(this)
  $wrap = $this.closest('.roof-rail-calculator-wrap')
  $total_price = $wrap.find('.rrp-price')

  price = parseInt($wrap.find('input[name="price"]').val())
  console.log 'one price :', price

  quantity = parseInt($wrap.find('input[name="quantity"]').val())
  console.log 'quantity :', quantity

  width_el = parseInt($wrap.find('.width-roof-rail p').text())
  console.log 'width :', width_el

  long_el = parseInt($wrap.find('input[name="long"]').val())
  console.log 'long :', long_el

#  total_price = (long_element* weight_element)*count_element+gag_price
  $total_price.text(Math.round(price))


$(document).ready ->

#===================================================================
#  roof and rail banner
#===================================================================
  $("ul#roof-rail-banner").bxSlider
    auto: true,
    pause: 5000,
    controls: false

#===================================================================
#  mixItUp
#===================================================================
  $('#roof-rail-container').mixItUp()

#===================================================================
#  roof rail filters
#===================================================================
  $('body').on "change",".catalog-rr-radio-element input[type='radio']", ->
    key_step = $(@).closest('.catalog-rr-radio-element').attr('data-key')

#    console.log 'is key step : ', key_step
    $this = $(@)
    $parent = $this.closest('.catalog-rr-radio-element')
#    scenario = JSON.parse($parent.attr('data-scenario'))

#   variant ajax json
    action_link = $parent.attr('data-action')
#    console.log 'action link :'+ action_link
    $.getJSON action_link, (data) ->
#      console.log 'data : ',data
      $.each data, (i, value) ->
  #      console.log 'key: ' + i + ',value: ' + value

        if i == 'colors'
#          console.log 'color'
          $color_elemnet = $('.catalog-rr-one-color')
          $color_elemnet.removeClass('enable-catalog-element')
          $.each value, (i, item)->
#            console.log 'color each', item
            $color_elemnet.find("[value='#{item}']").closest('.catalog-rr-one-color').addClass("enable-catalog-element")
#            console.log 'this element:', $color_elemnet.find("[value='#{item}']")
        else
#          console.log 'not color'
          $current_item = $('.catalog-rr-color-system-group').find("[data-key='#{i}']")

          - unless i == 'producer'
  #          console.log 'current block = '+ i
  #          console.log 'wrap:', $current_item

            $step_item = $current_item.removeClass('enable-catalog-element')
            if typeof value != 'object'
              value = [value]
            checked = false
            $.each value, (i, item)->
  #            console.log 'value:', item

              $step_item.find("[value='#{item}']").closest('.catalog-rr-radio-element').addClass("enable-catalog-element")

  #            if !checked
              $step_item.find("[value='#{item}']").prop('checked', false)
  #            checked = true

#===================================================================
#  roof rail change color and photo with price
#===================================================================
  $('body').on "change",".catalog-rr-one-color.enable-catalog-element input[type='radio']", ->
    $this = $(@)
    $wrap = $this.closest('.catalog-one-item-page')
    $image = $wrap.find('.coi-photo .image')


    image_link = $(@).closest('.catalog-rr-one-color').attr "data-image"
    image_large_link = $(@).closest('.catalog-rr-one-color').attr "data-img-large"
    price = $(@).closest('.catalog-rr-one-color').attr "data-price"

    $wrap.find('input[name="price"]').val(price)
    $image.css 'background-image', 'url(' + image_link + ')'
    console.log 'large image :', image_large_link

    $image.parent().attr 'href', image_large_link

    deckingCalculator.call(this)


#===================================================================
#  roof & rail popup gallery
#===================================================================
  $('#roof-rail-gallery').lightGallery()


#  $('#dynamic').on 'click', ->
#    $(this).lightGallery
#      dynamic: true
#      dynamicEl: [
#        {
#          'src': '../static/img/1.jpg'
#          'thumb': '../static/img/thumb-1.jpg'
#          'subHtml': '<h4>Fading Light</h4><p>Classic view from Rigwood Jetty on Coniston Water an old archive shot similar to an old post but a little later on.</p>'
#        }
#        {
#          'src': '../static/img/2.jpg'
#          'thumb': '../static/img/thumb-2.jpg'
#          'subHtml': '<h4>Bowness Bay</h4><p>A beautiful Sunrise this morning taken En-route to Keswick not one as planned but I\'m extremely happy I was passing the right place at the right time....</p>'
#        }
#        {
#          'src': '../static/img/3.jpg'
#          'thumb': '../static/img/thumb-3.jpg'
#          'subHtml': '<h4>Coniston Calmness</h4><p>Beautiful morning</p>'
#        }
#      ]





