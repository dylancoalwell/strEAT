var map;
function initMap() {
  // Constructor creates a new map - only center and zoom are required.
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 41.877839, lng: -87.632345},
    zoom: 13
  });

  var geocoder = new google.maps.Geocoder();

  // function geocodeAddress is located in favorite_locations.js
  document.getElementById('submitAddress').addEventListener('click', function() {           handleCreatingFavoriteAddress(geocoder);
  });
} // end of initMap

// - we want to input an address into search box
// - a list of address will be returned
// - all returned addresses will be displayed below search
// - the user will select one address
//   or will search for a new address
// - when the address is selected the user will give a name for this
//   address, for example (home, work)
// - a button to save and submit will appear
// - form will be submitted containing name, address, lat, lng
