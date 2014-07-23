$(function() {
  var nav = navigator.userAgent;
  if(nav.indexOf('MSIE 8.0') > -1)
  {
    // on load show only first tab
    $('.content', '.tabs-content').removeClass('active').css('display', 'none');
    $('.content:first-child', '.tabs-content').addClass('active').css('display', 'block');

    // When user clicks on tabs link
    $('.tabs dd').on('click', 'a', function (event) {

      var currentPanel = '#' + this.href.split('#')[1];
      var currentElement = $(currentPanel);

      $(this).parents('.tabs').next('.tabs-content').children('.content').removeClass('active').css('display', 'none');
      currentElement.addClass('active').css('display', 'block');

    });
  }
});