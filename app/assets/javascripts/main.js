(function(){
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

  $(document).on('setup', '#public-link-dialog', function(event){
    event.stopPropagation();
    var $dialog = $(this);
    $dialog.find('input').focus(function(){
      $(this).select();
    });
    $dialog.modal({show: false});
  });

  $(document).on('show', '#public-link-dialog', function(event, href){
    event.stopPropagation();
    var $dialog = $(this);
    $dialog.find('input#link').val(href);
    $dialog.find('a#go').attr('href', href);
    $dialog.modal('show');
  });

  $(document).on('click', '.public-link', function(event) {
    event.preventDefault();
    $('#public-link-dialog').trigger('show', $(this).attr('href'));
    return false;
  });

  $(document).on('setup', '#posts-wall', function(event){
    event.stopPropagation();
    var $wall = $(this);  
    var options = {
      itemSelector: '.posts-wall-item',
      isFitWidth: true,
      gutter: 30
    };
    $wall.masonry(options);
  });

  $(document).ready(function(){
    $('img.sticker').tooltip();
    $('#scroll-to-top').trigger('setup');
    $('#public-link-dialog').trigger('setup');
    $('#posts-wall').trigger('setup');  
  });
})();