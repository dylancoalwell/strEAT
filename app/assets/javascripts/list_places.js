
function removeDuplicatesFromList(list) {
  for ( var i = 0; i < list.length; i++ ) {
    for ( var j = 0; j < list.length; j++ ) {
      if(list[i].place_id == list[j].place_id) {
        list.splice(j, 1);
      }
    }
  }
  return list;
}

function showList(list) {
  $('#list-button').on('click', function(e) {
    var newList = removeDuplicatesFromList(list);
    e.preventDefault();
    placeList(newList);
  });
};

function placeList(list) {
  $('#map').slideUp(1000);
  list.forEach(function(singleItem) {
    var address = encodeURIComponent(singleItem.vicinity)
    var mapsUrl = "http://maps.google.com/maps?dirflg=w&saddr="+currentPosition.coords.latitude+","+currentPosition.coords.longitude+"&daddr="+address+"&dirflg=w"
    var listHtml = "<li class='card-title'><a style='{color: red}'href="+mapsUrl+">"+singleItem.name+"</a></li></li>"+singleItem.vicinity+"</li><br>"
    $('#restaurant-list').append(listHtml);
  });
};
