# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
#=============================================
# owl carousel from window and door page
#=============================================
  owleg = $("ul.available-colors-carousel")
  owleg.owlCarousel
    items: 5
    navigation: true

  gallery = null
  cii = null
  $('ul.available-colors-carousel .owl-item').click ->
    $wrap =$(@).closest('ul.available-colors-carousel')
    slides = $wrap.find('.image')

    cii = $(@).index()
    elmenetsListData = $.map($wrap.find('.image'), (el) ->
      {
        src: $(el).attr 'data-gallery-src'
        thumb: $(el).attr 'data-gallery-thumb'
      }
    )
#    console.log("cii", cii)
    $gallery = $('ul.available-colors-carousel')
    $gallery.lightGallery
      dynamic: true
      dynamicEl: elmenetsListData
      index: cii

    gallery ?= $gallery.data("lightGallery")
    gallery.index = cii
#    console.log("gallery", gallery)
    window.gallery = gallery

#=============================================
# windows and door avatar
#=============================================
  $('.wd-other-type').click ->
    $this = $(@)
    $wrap = $this.closest('.wd-item-avatar-wrap')

    image_src = $this.attr 'data-image'
    $wrap.find('.wd-item-avatar .image').css('background',"url('#{image_src}')no-repeat center center")

    console.log 'file: ', image_src