
$(function(){
  var graphs = $('.chart')

  var graphCreate = function(graphData) {
     new Morris.Line({
        // ID of the element in which to draw the chart.
        element: $(graphData).attr("id"),
        data: $(graphData).data("graphData"),
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
  } 

  var graphSetup = function(graphs){
    $.each(graphs, function (i) {
      var graph = graphs[i]
      return graphCreate(graph);
    })
  };
  graphSetup(graphs)
});