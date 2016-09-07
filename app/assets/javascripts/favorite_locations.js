function loadFavorites() {
  var geocoder = new google.maps.Geocoder();
  $("#submitAddress").on("click", function() {
    $("#returnedAddresses").remove();
    handleCreatingFavoriteAddress(geocoder);
  }) // end of submit button handler


}; // end of loadFavorites


function handleCreatingFavoriteAddress(geocoder) {
  // # make this a part a view function?
  var address = document.getElementById('address').value;

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
    if (name.trim() != "") {
      saveFavoriteLocation(name, results[addressID]);
    } else {
      $("#favorite-name").attr("placeholder","Please enter a name");
      $("#favorite-name").addClass("error");
    }
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
  .done(function(response) {
    // debugger;
    $("#returnedAddresses").remove();
     // var url = $(location).attr("href")
     console.log("in done")
     console.log(response)
     console.log("leaving done")
     $(location).attr("href",response)
    // $(location).attr("href",postUrl)


  })
  .fail(function(response) {
    console.log(response);
  })
  .always(function() {
    console.log("in always")
    // console.log("complete");
  });

  $("#returnedAddresses").remove();

}

