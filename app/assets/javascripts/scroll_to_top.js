function initBackToTop() {
  var link = $('#scroll-to-top')
  link.tooltip();
  link.click(function() {
    $("html, body").animate({ scrollTop: 0 }, 1000);
    return false;
  });

  $(window).scroll(function() {
    if ($(this).scrollTop()) {
      $('#scroll-to-top:hidden').stop(true, true).fadeIn();
    } else {
      $('#scroll-to-top').stop(true, true).fadeOut();
    }
  });
}

$(document).ready(initBackToTop);