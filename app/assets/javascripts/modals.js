 $(function() {
   // For creating modal fields.
	$('form .add_modal').on('click', function(event) {
		$('.modal').modal( 'show' );
		// Lets the cancel button know about the extra fields.
		$('.modal .cancel-modal').on('click', cancelModal );
    // $('.modal').on('hidden', function(){ saveModal(); })
		$('.save-modal').click(function(e) {saveModal(e)});
	});

	function saveModal(event) {
    event.preventDefault();
		var message = $('#new-message-text-area').val();
    var newMessage = $.ajax({
      data: { message_text: message },
      type: 'post',
      url: "/admin/messages/"
    });

		$('.modal').modal( 'hide' );
	}

	function cancelModal(event) {
		$(this).parents('.modal').modal('hide');
    $(this).prev('.fieldset').remove();
    event.preventDefault();
  }
});