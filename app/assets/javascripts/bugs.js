(function() {
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

  $(document).ready(function(){
    $('#post-bug-dialog').trigger('setup');
    $('.bug-in-post').click(function(event){
      event.preventDefault();
      $('#post-bug-dialog').trigger('show');
      return false;
    });
  });
})();