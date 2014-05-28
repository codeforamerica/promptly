$(function () {
  var graphs = $('.chart');

  var graphCreateLine = function (graphData) {
    var keys = Object.keys($(graphData).data("graphData")[0]);
    var yKeyList = [];
    for (var i = 1; i < keys.length; i++){
            yKeyList.push(keys[i]);
          }
    new Morris.Line({
      // ID of the element in which to draw the chart.
      element: $(graphData).attr("id"),
      data: $(graphData).data("graphData"),
      // The name of the data record attribute that contains x-values.
      xkey: keys[0],
      // A list of names of data record attributes that contain y-values.
      ykeys: yKeyList,
      dateFormat: function (date) {
        d = new Date(date);
        return (d.getMonth() + 1) + '/' + (d.getDate()) + '/' + d.getFullYear();
      },
      // Labels for the ykeys -- will be displayed when you hover over the
      // chart.
      labels: ['Messages'],
      xLabelFormat: function (date) {
        return (date.getMonth() + 1) + '/' + (date.getDate()) + '/' + date.getFullYear();
      },
      smooth: false,
      grid: true,
      pointSize: '3px'
    });
  };

  var graphCreateBar = function (graphData) {
    var keys = Object.keys($(graphData).data("graphData")[0]);
    var yKeyList = [];
    for (var i = 1; i < keys.length; i++){
      yKeyList.push(keys[i]);
    }
    Morris.Bar({
      element: $(graphData).attr("id"),
      data: $(graphData).data("graphData"),
      xkey: 'date',
      ykeys: ['number_sent0', 'number_sent1'],
      labels: ["Messages", "Calls"],
      barColors: ['#2E88CC', '#A7DBD8']
    });
  };

  var graphCreateDonut = function (graphData) {
    Morris.Donut({
      element: $(graphData).attr("id"),
      data: $(graphData).data("graphData")
    });
  };

  var graphSetup = function (graphs) {
    $.each(graphs, function (i) {
      var graph = graphs[i];
      if ($(graph).hasClass('bar')) {
        return graphCreateBar(graph);
      } else {
        return graphCreateLine(graph);
      }
    });
  };
  graphSetup(graphs);

// From https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys
if (!Object.keys) {
  Object.keys = (function () {
    'use strict';
    var hasOwnProperty = Object.prototype.hasOwnProperty,
        hasDontEnumBug = !({toString: null}).propertyIsEnumerable('toString'),
        dontEnums = [
          'toString',
          'toLocaleString',
          'valueOf',
          'hasOwnProperty',
          'isPrototypeOf',
          'propertyIsEnumerable',
          'constructor'
        ],
        dontEnumsLength = dontEnums.length;

    return function (obj) {
      if (typeof obj !== 'object' && (typeof obj !== 'function' || obj === null)) {
        throw new TypeError('Object.keys called on non-object');
      }

      var result = [], prop, i;

      for (prop in obj) {
        if (hasOwnProperty.call(obj, prop)) {
          result.push(prop);
        }
      }

      if (hasDontEnumBug) {
        for (i = 0; i < dontEnumsLength; i++) {
          if (hasOwnProperty.call(obj, dontEnums[i])) {
            result.push(dontEnums[i]);
          }
        }
      }
      return result;
    };
  }());
}

});