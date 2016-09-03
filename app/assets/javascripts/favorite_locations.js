function geocodeAddress(geocoder) {
  var address = document.getElementById('address').value;
  var confirmation;
  geocoder.geocode({'address': address}, function(results, status) {
    var addressResult = document.getElementById('addressResult');
    console.log(results.length)
    if (status === google.maps.GeocoderStatus.OK) {
      addressResult.innerHTML="The search found the following address: " + results[0].formatted_address + " is this correct?";
      $(".confirm-btn").show();
      $(".confirm-btn").on("click", function(){
        confirmation = $(this).val();
        console.log(confirmation)
      })
    } else {
      addressResult.innerHTML = 'Address search was not successful for the following reason: ' + status;
    }
  });
}

function confirmAddress(){

}


// name
// address
// lat
// lng
// user_id
