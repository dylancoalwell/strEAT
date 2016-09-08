
function removeDuplicatesFromList(list) {
  for ( var i = 0; i < list.length; i++ ) {
    for ( var j = 0; j < list.length; j++ ) {
      if(list[i].place_id == list[j].place_id && list.indexOf(list[i]) != list.indexOf(list[j])) {
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
  $('#map').slideToggle(1000, function(){
    if($('#list-icon').text() == 'list') {
      $('#list-icon').text('directions');
      list.forEach(function(singleItem) {
        appendListHtml(singleItem);
      });
    }else{
      $('#list-icon').text('list');
    };
  });
};

function appendListHtml(item) {
  var price = parseInt(item.price_level)
  var attachMoney = "attach_money"
  var moneySignsBaby = attachMoney.repeat(price)
  var coolHtml = "<i class='material-icons'>"+moneySignsBaby+"</i>"
  var address = encodeURIComponent(item.vicinity)
  var mapsUrl = "http://maps.google.com/maps?dirflg=w&saddr="+currentPosition.coords.latitude+","+currentPosition.coords.longitude+"&daddr="+address+"&dirflg=w"
  var listHtml = "<li class='card-title'><a href="+mapsUrl+">"+item.name+"</a></li><li>"+item.vicinity+"</li><li>"+coolHtml+"</li><br>"
  $('#restaurant-list').append(listHtml);
};
