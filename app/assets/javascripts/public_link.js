function initPublicLink() {
  var dialog = $('#public-link-dialog').modal({show: false});
  $(document).on('click', '.public-link', function(event) {
    event.preventDefault();
    dialog.find('input#link').val($(this).attr('href'));
    dialog.find('a#go').attr('href', $(this).attr('href'));
    dialog.modal('show');
    return false;
  });

  $('#public-link-dialog input').focus(function(){
    $(this).select();
  });
}

$(document).ready(initPublicLink);