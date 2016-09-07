$(function () {
  $("#contact-location-request").on('submit', function(event) {
    event.preventDefault();
    $self = $(this)
    navigator.geolocation.getCurrentPosition(function (position) {
      handleRouteToFriend(event, $self, position);
    })
  });
});

function handleRouteToFriend(event, form, position) {
  message = form.find("#invite_message").val()
  $.ajax({
    url: form.attr('action'),
    method: 'POST',
    data: {
        message: message,
        sender_lat: position.coords.latitude,
        sender_lng: position.coords.longitude
    }
  }).done(function (response) {
    console.log(response)
  })
};
