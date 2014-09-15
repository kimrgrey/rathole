(function(){
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  }); 
  
  $(document).on('setup', '#scroll-to-top', function(event){
    event.stopPropagation();
    var $link = $(this);
    $link.tooltip();
    $link.click(function() {
      $("html, body").animate({ scrollTop: 0 }, 1000);
      return false;
    });
    $(window).scroll(function() {
      if ($(this).scrollTop() > $(window).height() && $link.css('z-index') > 0) {
        $link.fadeIn();
      } else {
        $link.fadeOut();
      }
    });
  });

  $(document).ready(function(){
    $('*[title]').tooltip();
    $('#scroll-to-top').trigger('setup');
  });
})();