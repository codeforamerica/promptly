 $(function() {
//   // Handler adding form fields
// 	$('form .add_fields').on('click', function(event) {

// 		$('form #reminder_report_id').parentsUntil('.field').hide();

// 		time = new Date().getTime();
// 		regexp = new RegExp($(this).data('id'), 'g');
// 		$(this).before($(this).data('fields').replace(regexp, time));
// 		event.preventDefault();
// 		$(this).hide();

// 		// Lets the cancel button know about the extra fields.
// 		$('form .cancel').on('click', cancelClicked );
// 	});

// 	function cancelClicked(event) {
// 		$(this).hide()
//     $(this).prev('fieldset').remove();
//     $('form #reminder_report_id').parentsUntil('.field').show();
//     $('form .add_fields').show();
//     event.preventDefault();
//   }
// });
//https://github.com/Nerian/bootstrap-datepicker-rails
  $('.dateSelect').datepicker({
  	format: 'yy-mm-dd'
  });

  $('#reminder_message_text').live('keyup keydown', function(e) {
	  var maxLen = 160;
	  var charLeft = maxLen - $(this).val().length;
	  $('#char-count').html(charLeft);
	});
});
