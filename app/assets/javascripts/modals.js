 $(function() {
   // For creating modal fields.
	$('form .add_modal').on('click', function(event) {
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$(this).before($(this).data('fields').replace(regexp, time));
		event.preventDefault();
		// Lets the cancel button know about the extra fields.
		$('.modal .cancel-modal').on('click', cancelModal );
		$('.modal .save-modal').on('click', saveModal);
	});

	function saveModal(event) {
		$(this).parents('.modal').hide();
	}

	function cancelModal(event) {
		$(this).parents('.modal').modal('hide');
    $(this).prev('.fieldset').remove();
    event.preventDefault();
  }
});