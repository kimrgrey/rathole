(function() {
  function initComments() {
    $('.comments').on('click', '.edit-comment-link', function(event){
      event.preventDefault();
      var comment = $($(this).attr('href'));
      comment.find('.text').hide();
      comment.find('form').addClass('visible');
      $('#new-comment-form').hide();
      return false;
    });

    $('.comments').on('click', '.comment-edit-cancel', function(event){
      event.preventDefault();
      var comment = $($(this).attr('href'));
      comment.find('form').removeClass('visible');
      comment.find('.text').show();
      $('#new-comment-form').show();
      return false;
    });
  }

  $(document).ready(initComments);
})();