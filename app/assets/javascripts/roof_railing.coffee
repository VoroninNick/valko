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
#
#  data = [
#    {
#      'Id': 10004
#      'PageName': 'club'
#    }
#    {
#      'Id': 10040
#      'PageName': 'qaz'
#    }
#    {
#      'Id': 10059
#      'PageName': 'jjjjjjj'
#    }
#  ]
#
#  $.each data, (i, item) ->
#    console.log 'PageName i:',data[i].PageName
#
#  $.each data, (i, item) ->
#    console.log 'PageName item:',item.PageName





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



#    thickness_keys = scenario.thickness.filter(
#      (v)->
#        !!v
#    )
#
#    console.log 'keys:', thickness_keys
#
##    $.each thickness_keys, (i, item)->
##      $next_step_inputs = $("input")
##      $next_step_inputs.closest('.catalog-rr-radio-element').removeClass('enable-catalog-element')
##      $next_step_inputs.filter("[value='#{item}']").each ()->
##        $(@).closest('.catalog-rr-radio-element').addClass('enable-catalog-element')
#    $step_item = $('.catalog-rr-radio-element').removeClass('enable-catalog-element')
#    $.each thickness_keys, (i, item)->
#      console.log 'value:', item
#      $step_item.find("[value='#{item}']").closest('.catalog-rr-radio-element').addClass('enable-catalog-element')


