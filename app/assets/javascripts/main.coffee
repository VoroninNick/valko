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


$(document).ready ->
#===================================================================
#  promotion banner
#===================================================================
  $("ul#promotion-banner").bxSlider
    auto: true,
    pause: 5000,
    controls: false,
    pagerCustom: ".promotion-banner-pager"