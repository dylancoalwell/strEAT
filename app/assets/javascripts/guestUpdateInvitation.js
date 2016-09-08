function invitationsShowViewController() {
  $('#invitation-acceptance-post').on('submit',function function_name(event) {
    event.preventDefault();
    var $form = $(this);
    navigator.geolocation.getCurrentPosition(function (position) {
      handleInvitationAcceptance(position, $form)
    },
    geolocationErrorHandler, {
      enableHighAccuracy: true
    });
  });
};

function handleInvitationAcceptance(position, target) {
  console.log("handleInvitAccept", target)

  var invitationAcceptanceRequest = $.ajax({
    url: target.attr('action'),
    method: 'POST',
    data: {
      guest_lat: position.coords.latitude,
      guest_lng: position.coords.longitude
    }
  })

  invitationAcceptanceRequest.done(acceptInvitationRedirect())
}

function acceptInvitationRedirect() {
  console.log("YAY!")
}
