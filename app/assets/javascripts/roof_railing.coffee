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

#===================================================================
#  roof rail filters
#===================================================================
  $('body').on "change",".catalog-rr-radio-element input[type='radio']", ->
    console.log 'is'
    $this = $(@)
    $parent = $this.closest('.catalog-rr-radio-element')
    scenario = $parent.attr('data-scenario')
#
    console.log 'scenario :',scenario
    json_obj = JSON.stringify(scenario)
    console.log 'ready:', json_obj

#    data =
#      'name': ''
#      'skills': ''
#      'jobtitel': 'Entwickler'
#      'res_linkedin': 'GwebSearch'
#    parsedData = JSON.parse(scenario)
#    alert parsedData
#  do ->
#    oJson =
#      'name': ''
#      'skills': ''
#      'jobtitle': 'Entwickler'
#      'res_linkedin': 'GwebSearch'
#    alert oJson.jobtitle