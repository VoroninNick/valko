map = undefined
initialize = ->
  $map = $('#map_canvas')
  lat = $map.attr 'data-lat'
  lng = $map.attr 'data-lng'

  address = $map.attr 'data-address'
  city = $map.attr 'data-city'

  myLatlng = new (google.maps.LatLng)(lat, lng)

  styles = [
    {
      stylers: [
        { "Saturation": "-100" }
#        { "hue": "#ff7700" },
#        { "lightness": -2 },
#        { "gamma": 0.69 }
      ]
    }
  ]
#
  styledMap = new google.maps.StyledMapType(styles,
    name: "Styled Map"
  )

  mapOptions =
    zoom: 17
    center: myLatlng
    scrollwheel: false
    mapTypeIds: [
      google.maps.MapTypeId.ROADMAP
      "map_style"
    ]

  map = new (google.maps.Map)(document.getElementById('map_canvas'), mapOptions)
  map.mapTypes.set "map_style", styledMap
  map.setMapTypeId "map_style"

  contentString = "<div id=\"content\">" + "<div id=\"siteNotice\">" + "</div><div class=\"info-window\"><div class=\"address\"><p>"+address+"</p></div></div>" + "</div>"
  infowindow = new (google.maps.InfoWindow)(
    content: contentString

  )
  marker = new (google.maps.Marker)(
    position: myLatlng
    map: map
    title: 'Budapest'
    icon: '/assets/Valko-icon-location.svg')
  google.maps.event.addListener marker, 'click', ->
    infowindow.open map, marker

google.maps.event.addDomListener window, 'load', initialize

# on resize map will allways centered
google.maps.event.addDomListener window, 'resize', ->
  center = map.getCenter()
  google.maps.event.trigger map, 'resize'
  map.setCenter center
