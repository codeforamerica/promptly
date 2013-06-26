jQuery ->
  # $('#reminder_report_id').parent().hide()
  reports = $('#reminder_report_id').html()
  $('#reminder_program_id').change ->
    program = $('#reminder_program_id :selected').text()
    escaped_program = program.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(reports).filter("optgroup[label='#{escaped_program}']").html()
    if options
      $('#reminder_report_id').html(options)
      $('#reminder_report_id').parent().show()
    else
      $('#reminder_report_id').empty()
      $('#reminder_report_id').hide()