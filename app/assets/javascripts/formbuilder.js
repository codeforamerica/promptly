$(function() {
  // Handler adding form fields
	$('form .add_fields').on('click', function(event) {

		$('form #reminder_report_id').parent().hide();

		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$(this).before($(this).data('fields').replace(regexp, time));
		event.preventDefault();
		$(this).hide();
		console.log("added");
		$('form .cancel').on('click', cancelClicked );
	});

	function cancelClicked(event) {
		console.log("cancel");
    $(this).parent().remove();
    $('form #reminder_report_id').parent().show();

    event.preventDefault();
	}
});