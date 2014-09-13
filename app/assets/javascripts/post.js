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

  $(document).on('setup', '#post-bug-dialog', function(event){
    event.stopPropagation();
    var $dialog = $(this).modal({show: false});
    $dialog.on('click', '#go', function(event){
      event.preventDefault();
      var $note = $dialog.find('#note');
      if ($note.val().length == 0) {
        $note.closest('.form-group').addClass('has-error');
      } else  {
        $dialog.find('form').submit();
      }
      return false;
    });
  });

  $(document).on('show', '#post-bug-dialog', function(event){
    event.stopPropagation();
    var $dialog = $(this);
    var text = getSelection().toString();
    $dialog.find('#fragment').val(text);
    if (text && text.length > 0) {
      $dialog.find('#label-for-fragment').show();
      $dialog.find('#fragment').show();
    } else {
      $dialog.find('#label-for-fragment').hide();
      $dialog.find('#fragment').hide();
    }
    $dialog.find('#note').val('');
    $dialog.find('.form-group').removeClass('has-error');
    $dialog.modal('show');
  });

  $(document).ready(function() {
    $('.comments').trigger('setup');
    $('#post-bug-dialog').trigger('setup');
    $('.bug-in-post').click(function(event){
      event.preventDefault();
      $('#post-bug-dialog').trigger('show');
      return false;
    });
  });
})();