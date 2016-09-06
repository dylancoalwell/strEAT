$(document).ready(function () {
  var geocoder;

  console.log("check, FavoriteLocation");

  $('#submitAddress').on('click', function () {
    geocoder = new google.maps.Geocoder();
    handleCreatingFavoriteAddress(geocoder);
  })
})

function handleCreatingFavoriteAddress() {
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

  $("#address-search-panel").append('<div id="returnedAddresses"></div>')
  $("#returnedAddresses").append('<label>Enter name of location<input id="favorite-name" type="textbox" VALUE=""></label>')
  $("#returnedAddresses").append('<p>Select favorite location from below</p>')

  $.each(results, function(index, result) {
    $("#returnedAddresses").append('<div class="address" id="address-' + index + '">' + result.formatted_address + '</div>')
  }) // end of each block

  $(".address").on('click',  function() {
    var name = $("#favorite-name").val()
    console.log(name)
    console.log("target  ", event.target)
    addressID = $(this).attr("id").split("-")[1]
    console.log(addressID)
    saveFavoriteLocation(name, results[addressID])
  }) // end of click handler
}

function saveFavoriteLocation(favTitle, favObj) {
  var url = $(location).attr("href")
  console.log(url)
  var re = /(\S*)(\/users)(\S*)(\/new)/i
  var postUrl = url.replace(re,("$2$3"))
  console.log("posturl",postUrl)

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
  .done(function() {
    console.log("success");
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });

  $("#returnedAddresses").remove();
}
