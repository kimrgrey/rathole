(function() {
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

  $(document).ready(function(){
    $('#public-link-dialog').trigger('setup');
  });
})();
