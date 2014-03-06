
$(function(){
  graphs = [
  'upcoming',
  'sent',
  'response',
  'undelivered',
  'calls'
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
        dateFormat: function(date) {
          d = new Date(date);
          return (d.getMonth()+1)+'/'+(d.getDate())+'/'+d.getFullYear(); 
          },
        // Labels for the ykeys -- will be displayed when you hover over the
        // chart.
        labels: ['Messages'],
        xLabelFormat: function(date) {
          return (date.getMonth()+1)+'/'+(date.getDate())+'/'+date.getFullYear(); 
          },
        smooth: false,
      });
    })
  };
});