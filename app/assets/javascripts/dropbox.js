function listenDropboxChooser() {
  $('.dropbox').on('DbxChooserSuccess', '#dropbox-chooser', function(e) {
    $(this).closest('form').submit();
  });
}

$(document).ready(listenDropboxChooser);

