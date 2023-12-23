$(document).on('turbolinks:load', function() {
  $('#back').hide();
  $(window).scroll(function() {
    if ($(this).scrollTop() > 0) {
      $('#back').fadeIn();
    } else {
      $('#back').fadeOut();
    }
  });

  $('#back a').on('click', function(event) {
    $('body, html').animate({
      scrollTop: 0
    }, 800);
    event.preventDefault();
  });
});