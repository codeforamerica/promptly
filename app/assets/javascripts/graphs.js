
$(function(){
  graphs = [
  'upcoming',
  'sent',
  'response',
  'undelivered'
  ]

  createGraphs(graphs)

  function createGraphs(graphs){
    graphs.forEach(function (graph) {
      new Morris.Line({
        // ID of the element in which to draw the chart.
        element: graph+'_chart',
        data: $('#'+graph+'_chart').data(graph),
        // The name of the data record attribute that contains x-values.
        xkey: 'date',
        // A list of names of data record attributes that contain y-values.
        ykeys: ['number_sent'],
        // Labels for the ykeys -- will be displayed when you hover over the
        // chart.
        labels: ['Number of Recipients'],
        smooth: false
      });
    })
  };
});