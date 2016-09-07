
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
    console.log(newList.length);
  });
};
