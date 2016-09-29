# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
#=============================================
# owl carousel from window and door page
#=============================================
  $('ul.available-colors-carousel').owlCarousel
    items: 5
    navigation: true


#=============================================
# windows and door avatar
#=============================================
  $('.wd-other-type').click ->
    $this = $(@)
    $wrap = $this.closest('.wd-item-avatar-wrap')

    image_src = $this.attr 'data-image'
    console.log 'file: ', image_src