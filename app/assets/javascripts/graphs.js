$(function() {
  upcomingMessages();
  sentMessages()
});

function upcomingMessages(){
  new Morris.Line({
    // ID of the element in which to draw the chart.
    element: 'upcoming_chart',
    data: $('#upcoming_chart').data('upcoming'),
    // The name of the data record attribute that contains x-values.
    xkey: 'send_date',
    // A list of names of data record attributes that contain y-values.
    ykeys: ['number_sent'],
    // Labels for the ykeys -- will be displayed when you hover over the
    // chart.
    labels: ['Number of Recipients']
  });
};

function sentMessages(){
  new Morris.Line({
    // ID of the element in which to draw the chart.
    element: 'sent_chart',
    data: $('#sent_chart').data('sent'),
    // The name of the data record attribute that contains x-values.
    xkey: 'sent_date',
    // A list of names of data record attributes that contain y-values.
    ykeys: ['number_sent'],
    // Labels for the ykeys -- will be displayed when you hover over the
    // chart.
    labels: ['Number of Recipients']
  });
};