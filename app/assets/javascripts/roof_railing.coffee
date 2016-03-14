# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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