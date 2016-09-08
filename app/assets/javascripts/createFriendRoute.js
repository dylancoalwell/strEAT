function handleFriendRouteGeneration() {
  // this is currently uses functions declared
  // in the global scope to find things along a route.
  // the file containing the global functions is directions.js

  // console.log($(location).attr('href'))
  var directionsService = new google.maps.DirectionsService;
  var directionsRenderer = new google.maps.DirectionsRenderer;
  var routeDataRequest = $.ajax({
    url: $(location).attr('href')
  })

  routeDataRequest.done(function (response) {
    console.log(response)


    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 10,
      center: new google.maps.LatLng(response.origin.lat, response.origin.lng)
    });
    console.log(map)
    directionsRenderer.setMap(map)

    calculateAndDisplayRoute(directionsService, directionsRenderer, response.origin, response.destination)
 })


function calculateAndDisplayRoute(directionsService, directionsRenderer, origin, destination) {

  directionsService.route({
    origin: new google.maps.LatLng(origin.lat, origin.lng),
    destination:  new google.maps.LatLng(destination.lat, destination.lng),
    travelMode: 'WALKING'
  }, function(response, status) {

    if (status === 'OK') {
      directionsRenderer.setDirections(response);

      var path = response.routes[0].overview_path;
      // bounds = routeBoxer.box(path, distance);
      searchPath(path);

    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
}

  function initializeMap() {
    console.log("test")
  }
}


