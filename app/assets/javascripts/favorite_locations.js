// This function allows a user to input an address and
// will be looked up in Google Maps
// called by google-maps.js
function handleCreatingFavoriteAddress(geocoder) {
  // # make this a part a view function?
  var address = document.getElementById('address').value;

  // # It's own function that is solely responsible to hitting google for addresses
  geocoder.geocode({'address': address}, function(results, status) {
    // # maybe see if this can be moved to a call back?
    var confirmation;
    if (status === google.maps.GeocoderStatus.OK) {
      displayReturnedAddress(results)
    } else {
      // # add code for error handling
      console.log('errors were encountered');
    }
  });


}

// is called by handleCreatingFavoriteAddress
// This function dynamically appends a div to the address-search panel.
// It will loop through all the results sent by the geocode lookup
// Each item will appear as an option
function displayReturnedAddress(results) {
  console.log(results)
  // append select to returnedAddresses div
  $("#address-search-panel").append('<div id="returnedAddresses"></div>')
  $("#returnedAddresses").html('<form id="addressSelector"></form>')
  $("#addressSelector")
  $.each(results, function(index, result) {
    $("#addressSelector").append(
    $('<input type="radio" name="' + index +  '" value="' + result.formatted_address + '" class="address" /> '  + result.formatted_address + '<br>'))
  }) // end of each block

  $("#addressSelector").append($('<input id="add-submit" type="submit" type="button" value="Add Favorite">'))
  $("#returnedAddresses").on("submit","#addressSelector", function(event) {
    event.preventDefault()

    var selectedIndex = $(".address:checked").attr("name");
    saveFavoriteLocation(results[selectedIndex]);
    $("#addressSelector").remove();

  }) // end of submit block

  // # this code ensures the active radio button is selected
  $('#address-search-panel').on('change', 'input[type=radio]', function(){
    $('input[type=radio]').not(this).prop('checked', false);
  }); // end of unique radio button logic
}




// called by displayReturnedAddress
// This function will allow the user to assign a name to the location
// and save address to the users favorite locations
function saveFavoriteLocation(favorite) {
  // remove address selector
  // show saved name input box
  // submit ajax to save location

  var address = favorite.formatted_address;
  var lat = favorite.geometry.location.lat();
  var lng = favorite.geometry.location.lng();
  console.log("address: ", address, "lat: ", lat, "lng: ", lng)
  // var data = {
  //   name: favorite.formatted_address

  // }
  console.log("lat" + favorite.geometry.location.lat())
  $("#addressSelector").remove();
  var saveLocationData =
  '<div id="saveLocation"><form action="/user/1/favorite_locations" method="post"><label for="name">Name for location</label><input type="text" name="name" placeholder="name"><br><input type="hidden" name="address"><br><input type="hidden" value="Add Location"></form></div>';
  $("#favorite-location").append(saveLocationData);

}

// '<div id="form">
//   <form action="/user/1/favorite_locations" method="post">
//     <label for="name">Name for location</label>
//     <input type="text" name="name" placeholder="name"><br>
//     <input type="hidden" name="address"><br>
//     <input type="hidden" value="Add Location">
//   </form>
// </div>
// '


// name
// address
// lat
// lng
// user_id
