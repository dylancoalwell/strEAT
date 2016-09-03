var map;
function initMap() {
  // Constructor creates a new map - only center and zoom are required.
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 41.877839, lng: -87.632345},
    zoom: 13
  });

  var geocoder = new google.maps.Geocoder();

  // function geocodeAddress called favorite_locations.js
  document.getElementById('submitAddress').addEventListener('click', function() {          geocodeAddress(geocoder);
  });
}
