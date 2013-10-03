 $(function() {
   // For creating modal fields.
	$('form .add_modal').on('click', function(event) {
		$('.modal').modal( 'show' );
		// Lets the cancel button know about the extra fields.
		$('.modal .cancel-modal').on('click', cancelModal );
    $('.modal').on('hidden', function(){ saveModal(); })
		// $('.save-modal').on('click', saveModal());
	});

	function saveModal(event) {
    console.log("i'm saved!");
		var message = $('#new-message-text-area').val();
    $.ajax({
      data: { message_text: message },
      type: 'post',
      url: "/admin/messages/"
    })
    .done(function(data) {
      console.log(data);
    });

		$('.modal').modal( 'hide' );
	}

	function cancelModal(event) {
		$(this).parents('.modal').modal('hide');
    $(this).prev('.fieldset').remove();
    event.preventDefault();
  }
});