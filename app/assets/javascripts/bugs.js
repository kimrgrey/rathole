(function() {
  function initBugs() {
    var dialog = $('#post-bug-dialog').modal({show: false});

    function showBugDialog(text) {
      dialog.find('#fragment').val(text);
      if (text && text.length > 0) {
        dialog.find('#label-for-fragment').show();
        dialog.find('#fragment').show();
      } else {
        dialog.find('#label-for-fragment').hide();
        dialog.find('#fragment').hide();
      }
      dialog.find('#note').val('');
      dialog.find('.form-group').removeClass('has-error');
      dialog.modal('show');
    }

    dialog.find('#go').click(function(event){
      event.preventDefault();
      var note = dialog.find('#note');
      if (note.val().length == 0) {
        note.closest('.form-group').addClass('has-error');
      } else  {
        dialog.find('form').submit();
      }
      return false;
    });

    $('.bug-in-post').click(function(event){
      event.preventDefault();
      var text = getSelection().toString();
      showBugDialog(text);
      return false;
    });
  }

  $(document).ready(initBugs);
})();