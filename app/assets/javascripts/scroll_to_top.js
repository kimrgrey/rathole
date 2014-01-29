function initBackToTop() {
  var link = $('#scroll-to-top');
  
  link.tooltip();

  link.click(function() {
    $("html, body").animate({ scrollTop: 0 }, 1000);
    return false;
  });

  $(window).scroll(function() {
    if ($(this).scrollTop() > $(window).height() && link.css('z-index') > 0) {
      link.fadeIn();
    } else {
      link.fadeOut();
    }
  });
  
}

$(document).ready(initBackToTop);