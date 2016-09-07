var savedPlaces = [];
function handleDirections() {
  // var map;
  navigator.geolocation.getCurrentPosition(initDirections, geolocationErrorHandler, {
    enableHighAccuracy: true
  })
}

function geolocationErrorHandler() {
}

function initDirections(position) {
  var url = $(location).attr('href')
  var re = /(\S*)(\/directions)(\S*)/i
  var postUrl = url.replace(re,("$3"))

  console.log("postURL", postUrl)

  var finalUrl =  '/favorite_locations' +  postUrl

  console.log(finalUrl)

  $.ajax({
    url: finalUrl
  }).done(function (res) {

    console.log("responding...")
    console.log(res)

    var directionsService = new google.maps.DirectionsService;
    var directionsRenderer = new google.maps.DirectionsRenderer;

    // center: {lat: 41.85, lng: -87.65}
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 10,
      center: new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    });

    console.log("new map variable/object set")

    directionsRenderer.setMap(map);

    // service = new google.maps.places.PlacesService(map);
    console.log("service set")

    calculateAndDisplayRoute(directionsService, directionsRenderer, position, res)

  })
}

function calculateAndDisplayRoute(directionsService, directionsRenderer, origin, destination) {
  // console.log("calculateAndDisplayRoute")
  // var routeBoxer = new RouteBoxer();

  // var distance = 0.001; // km

  directionsService.route({
    origin: new google.maps.LatLng(origin.coords.latitude, origin.coords.longitude),
    destination:  new google.maps.LatLng(destination.lat, destination.lng),
    travelMode: 'WALKING'
  }, function(response, status) {
    // console.log("directions service route setup good")
    if (status === 'OK') {
      // console.log("good status")
      directionsRenderer.setDirections(response);

      var path = response.routes[0].overview_path;
      // bounds = routeBoxer.box(path, distance);
      searchPath(path);

    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
}

function searchPath(path) {
  console.log("search path running")
  for (var i = 0; i < path.length; i++) {
    // console.log("looping i at:", i)
    (function (i) {
      // console.log("anon func running with i at:", i)
      setTimeout(function () {
        // console.log("timeout runnning with i at:", i)
        performSearch(path[i]);
      }, 1000 * i);
    }(i));
  }
}

function performSearch(pathNode) {
  console.log("performSearch")
  var nearRequest = {
    location: pathNode,
    radius: 100,
    // keyword: 'Burgers',
    type: 'restaurant',
    openNow: true
  };
  var service = new google.maps.places.PlacesService(map);
  service.nearbySearch(nearRequest, nearCallback)
}

function nearCallback(results, status) {
  console.log("in NEARCALLBACK")
  if (status == google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      savedPlaces.push(results[i])
      createMarker(results[i]);
    }
  }
  console.log(status)
}

function createMarker(place) {
  var location = place.geometry.location;
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location,
    title: place.name
  });
  var infowindow = new google.maps.InfoWindow({
    content: place.name + '<br>' + place.vicinity
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
}


