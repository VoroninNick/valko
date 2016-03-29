# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

deckingCalculator = () ->
  $this = $(this)
  $wrap = $this.closest('.catalog-one-item-page')
  $total_price = $wrap.find('.rrp-price')

  price = parseInt($wrap.find('input[name="price"]').val())
  console.log 'one price :', price

  quantity = parseInt($wrap.find('input[name="quantity"]').val())
  console.log 'quantity :', quantity

  width_el = parseInt($wrap.find('.width-roof-rail p').text())
  console.log 'width :', width_el

  long_el = parseInt($wrap.find('input[name="long"]').val())
  console.log 'long :', long_el

  total_price = (((width_el/1000)* (long_el/1000))*quantity)*price
  $total_price.text(Math.round(total_price))


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
    $this = $(@)
    $wrap = $this.closest('.catalog-one-item-page')
    $parent = $this.closest('.catalog-rr-radio-element')
    action_link = $wrap.attr('data-action')



    if $parent.attr('data-key') == "producer"
      DataToSend =
        producer: $wrap.find('input[name="catalog-rr-producer"]:checked').val()

    else if $parent.attr('data-key') == "thickness"
      DataToSend =
        producer: $wrap.find('input[name="catalog-rr-producer"]:checked').val()
        thickness: $wrap.find('input[name="catalog-rr-thickness"]:checked').val()

    else if $parent.attr('data-key') == "coating"
      DataToSend =
        producer: $wrap.find('input[name="catalog-rr-producer"]:checked').val()
        thickness: $wrap.find('input[name="catalog-rr-thickness"]:checked').val()
        coating: $wrap.find('input[name="catalog-rr-coating"]:checked').val()

    else if $parent.attr('data-key') == "protective_lamina"
      DataToSend =
        producer: $wrap.find('input[name="catalog-rr-producer"]:checked').val()
        thickness: $wrap.find('input[name="catalog-rr-thickness"]:checked').val()
        coating: $wrap.find('input[name="catalog-rr-coating"]:checked').val()
        lamina: $wrap.find('input[name="catalog-rr-protective_lamina"]:checked').val()

    $.ajax
      type: "POST"
      contentType: "application/json; charset=utf-8"
      url: action_link
      data: JSON.stringify(DataToSend)
      dataType: "json"
      before: ->
        console.log('before')

      success: (data) ->
        console.log('success')

        $.each data, (i, value) ->
          console.log 'key :', i

          if i == 'colors'
            console.log 'value :', value

            $color_elemnet = $('.catalog-rr-one-color')
            $color_elemnet.removeClass('enable-catalog-element')
            console.log 'color :'
            $.each value, (i, item)->
              console.log 'i :', item.title, 'item :', item

            $wrap.find('.catalog-rr-one-color input[type="radio"]').prop('checked', false)
            $.each value, (i, item)->
              $color_elemnet.find("[value='#{item.title}']").closest('.catalog-rr-one-color').addClass("enable-catalog-element")
              $color_elemnet.find("[value='#{item.title}']").closest('.catalog-rr-one-color').attr 'data-image', item.image
              $color_elemnet.find("[value='#{item.title}']").parent().attr 'href', item.image
              $wrap.find('input[name="price"]').val(item.price)

              console.log 'begin'
              deckingCalculator.call($this)
              console.log 'after'

              $current_color = $wrap.find("input[value='#{item.title}']").closest('.catalog-rr-one-color')
              $current_color.attr 'data-image', item.image
              $current_color.attr 'data-img-large', item.image_large
              $current_color.attr 'data-price', item.price

              if $current_color.find("input[value='#{item.title}']").closest('.coi-photo').find('input:radio:checked').length > 0
              else
                $current_color.find("input[value='#{item.title}']").prop('checked', true)
                $current_color_image = $wrap.find('.coi-photo .image')

                $current_color_image.css 'background-image', 'url(' + item.image + ')'
                $current_color_image.parent().attr 'href', item.image_large



          else
            $current_item = $('.catalog-rr-color-system-group').find("[data-key='#{i}']")
            console.log 'what is i :', i
            - unless i == 'producer'
              $step_item = $current_item.removeClass('enable-catalog-element')

              if typeof value != 'object'
                value = [value]

              checked = false
              $current_item.find('input[type="radio"]').prop('checked', false)

              $.each value, (i, item)->

                console.log 'value:', item

                $step_item.find("[value='#{item}']").closest('.catalog-rr-radio-element').addClass("enable-catalog-element")

                if $step_item.find("[value='#{item}']").closest('.catalog-rr-block-option').find('input:radio:checked').length > 0
                else
                  $step_item.find("[value='#{item}']").prop('checked', true)

      error: (err) ->
        alert "Error"

#    $.getJSON action_link, (data) ->



#===================================================================
#  roof rail calculator
#===================================================================
  $('#long-roof-rail, #count-roof-rail').change ->
    deckingCalculator.call(this)


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


#============================================================
# similar decking
#============================================================
$('#similar-decking').owlCarousel
  items: 1
  dotsContainer: '#similar-decking-dots'






