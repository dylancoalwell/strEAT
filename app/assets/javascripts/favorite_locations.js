// This function allows a user to input an address and
// will be looked up in Google Maps
// called by google-maps.js
function setFavoriteLocation() {
  console.log('click:')
}

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
  // append select to returnedAddresses div
  $("#address-search-panel").append('<div id="returnedAddresses"></div>')
  $("#returnedAddresses").append('<label>Enter name of location<input id="favorite-name" type="textbox" VALUE=""></label>')
  $("#returnedAddresses").append('<p>Select favorite location from below</p>')
  $.each(results, function(index, result) {
    $("#returnedAddresses").append('<div class="address" id="address-' + index + '">' + result.formatted_address + '</div>')
  }) // end of each block
  $(".address").on('click',  function() {
    var name = $("#favorite-name").val();
    addressID = $(this).attr("id").split("-")[1];
    console.log(addressID)
    if (name.trim() != "") {
      saveFavoriteLocation(name, results[addressID]);
    } else {
      console.log($("#favorite-name"))
      $("#favorite-name").val("Please enter a name");
      $("#favorite-name").addClass("error");
    }
  }) // end of click handler
}


//find


// called by displayReturnedAddress
// This function will allow the user to assign a name to the location
// and save address to the users favorite locations
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
  .done(function(response) {
    // debugger;
    console.log("success");
    $("#returnedAddresses").remove();
     var url = $(location).attr("href")
  console.log(response.responseText)
    // $("#returnedAddresses").append('<div class="return-link"> ' + result.formatted_address + '</div>')

  })
  .fail(function(response) {
    console.log("in fail")
    console.log(response);
  })
  .always(function() {
    console.log("in always")
    // console.log("complete");
  });

  $("#returnedAddresses").remove();
  // var saveLocationData =
  // '<div id="saveLocation"><form action="/user/1/favorite_locations" method="post"><label for="name">Name for location</label><input type="text" name="name" placeholder="name"><br><input type="hidden" name="address"><br><input type="hidden" value="Add Location"></form></div>';
  // $("#favorite-location").append(saveLocationData);

}

