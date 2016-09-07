// function evenMoreNearCallback(results, status) {
//   if (status == google.maps.places.PlacesServiceStatus.OK) {
//     for (var i = 0; i < results.length; i++) {
//       var place = results[i];
//       // debugger;
//       createMarker(results[i]);
//     }
//   }
//   console.log(status)
// }

// var map = new google.maps.Map(document.getElementById('map'), {
//       zoom: 10,
//       center: new google.maps.LatLng(position.coords.latitude, position.coords.longitude)

function showList() {
  $('#list-button').on('click', function(e) {
    e.preventDefault();
    console.log(savedPlaces[0].name);
  });
};
