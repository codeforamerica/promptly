(function() {
  jQuery(function() {
    var reports;
    reports = $('#reminder_report_id').html();
    return $('#reminder_program_id').change(function() {
      var escaped_program, options, program;
      program = $('#reminder_program_id :selected').text();
      escaped_program = program.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
      options = $(reports).filter("optgroup[label='" + escaped_program + "']").html();
      if (options) {
        $('#reminder_report_id').html(options);
        return $('#reminder_report_id').show();
      } else {
        $('#reminder_report_id').empty();
        return $('#reminder_report_id').hide();
      }
    });
  });

}).call(this);
