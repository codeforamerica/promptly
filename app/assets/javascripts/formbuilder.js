// $(function() {
//   // Handler adding form fields
// 	$('form .add_fields').on('click', function(event) {
// 		time = new Date().getTime();
// 		regexp = new RegExp($(this).data('id'), 'g');
// 		$(this).before($(this).data('fields').replace(regexp, time));
// 		event.preventDefault();
// 		$(this).hide()
// 	});

// 	$('form .remove_fields').on('click', function(event) {
//     $(this).prev('input[type=hidden]').val('1');
//     $(this).closest('fieldset').hide();
//     event.preventDefault();
// 	});
// });