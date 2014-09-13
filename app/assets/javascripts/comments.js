(function() {
  $(document).on('setup', '.comments', function(event){
    event.stopPropagation();

    var $comments = $(this);

    $(this).on('click', '.edit-comment-link', function(event){
      event.preventDefault();
      var $comment = $($(this).attr('href'));
      $comment.find('.text').hide();
      $comment.find('form').addClass('visible');
      $('#new-comment-form').hide();
      return false;
    });

    $(this).on('click', '.comment-edit-cancel', function(event){
      event.preventDefault();
      var $comment = $($(this).attr('href'));
      $comment.find('form').removeClass('visible');
      $comment.find('.text').show();
      $('#new-comment-form').show();
      return false;
    });

    $(this).on('click', '.reply-comment-link', function(event){
      event.preventDefault();
      var author = $(this).attr('data-author');
      var $textArea = $comments.find('#new-comment-form #body');
      var commentText = $textArea.val();
      if (commentText.length > 0) {
        commentText += "\r\n\r\n";
      }
      commentText += "**" + author + ":**";
      var selectedText = getSelection().toString();
      if (selectedText.length > 0) {
        commentText += "\r\n\r\n" + "> " + selectedText;
      }
      $textArea.val(commentText);
      $('html, body').animate({ scrollTop: $textArea.offset().top - 200}, 500);
      return false;
    });
  });

  $(document).ready(function() {
    $('.comments').trigger('setup');
  });
})();