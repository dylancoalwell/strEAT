$(document).ready(function () {
  var geocoder = new google.maps.Geocoder();;

  $('#submit-favorite-address').on('click', function () {
    handleCreatingFavoriteAddress(geocoder);
  })
})

function handleCreatingFavoriteAddress(geocoder) {

  var address = document.getElementById('address').value;

  geocoder.geocode({'address': address}, function(results, status) {

    var confirmation;

    if (status === google.maps.GeocoderStatus.OK) {
      displayReturnedAddress(results)
    } else {
      console.log('errors were encountered');
    }
  });

}

// is called by handleCreatingFavoriteAddress
// This function dynamically appends a div to the address-search panel.
// It will loop through all the results sent by the geocode lookup
// Each item will appear as an option
function displayReturnedAddress(results) {
  // append select to returnedAddresses div

  $("#favorite-address-search-panel").append('<div id="returnedAddresses"></div>')
  $("#returnedAddresses").append('<label>Enter name of location<input id="favorite-name" type="textbox" VALUE=""></label>')
  $("#returnedAddresses").append('<p>Select favorite location from below</p>')

  $.each(results, function(index, result) {
    $("#returnedAddresses").append('<div class="address" id="address-' + index + '">' + result.formatted_address + '</div>')
  }) // end of each block

  $(".address").on('click',  function() {

    var name = $("#favorite-name").val()

    addressID = $(this).attr("id").split("-")[1]

    saveFavoriteLocation(name, results[addressID])
  }) // end of click handler
}

function saveFavoriteLocation(favTitle, favObj) {
  var url = $(location).attr("href")
  var re = /(\S*)(\/users)(\S*)(\/new)/i
  var postUrl = url.replace(re,("$2$3"))

  $ajaxRequest = $.ajax({
    url: postUrl,
    method: 'POST',
    data: {
      favorite_location: {
        name: favTitle,
        address: favObj.formatted_address,
        lat: favObj.geometry.location.lat(),
        lng: favObj.geometry.location.lng()
      }
    }
  })
  .done(function(response) {
    console.log("success");
    console.log($("#returnedAddresses"))
    $("#returnedAddresses").remove();
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });



}
