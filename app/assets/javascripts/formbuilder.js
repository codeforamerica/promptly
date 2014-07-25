 $(function() {
//   // Handler adding form fields
  $('form .add_fields').on('click', function(event) {
    // $('form #reminder_report_id').parentsUntil('.field').hide();
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
    $(this).hide();
    // Lets the cancel button know about the extra fields.
    $('form .cancel').on('click', cancelClicked );
  });

  function cancelClicked(event) {
    $(this).hide();
    $(this).prev('fieldset').remove();
    // $('form #reminder_report_id').parentsUntil('.field').show();
    // $('form .add_fields').show();
    event.preventDefault();
  }

//https://github.com/Nerian/bootstrap-datepicker-rails

  $('#message_message_text').live('keyup keydown', function(e) {
    var maxLen = 160;
    var charLeft = maxLen - $(this).val().length;
    $('#char-count').html(charLeft);
  });
  $('.defaultTime').hover(
    function () {
      $(this).append($("<span>&nbsp;<a class='editTime btn btn-mini' href='#'>Edit</a></span>"));
    },
    function () {
      $(this).find("span:last").remove();
    }
  );
  $('.editTime').live("click", function(){
  $('#delivery_send_time').clone().attr('type','text').insertAfter('#delivery_send_time').prev().remove();
  $('<label for="delivery_send_date">Delivery time</label>').insertBefore('#delivery_send_time');
  $('.defaultTime').remove();
  });

  $('#messages-table').dataTable( {
        "sDom": '<"top"f>rt<"bottom"p><"clear">',
        "sPaginationType": "full_numbers",
        "oLanguage": {
          "sLengthMenu": "_MENU_ records per page"
        }
    } );
 

});
