(function(){
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

  $(document).on('setup', '#picture-upload-dialog', function(event){
    event.stopPropagation();
    var $dialog = $(this);
    var $form = $dialog.find('#upload-form')

    $form.on('change', '#files', function(event){
      event.preventDefault();
      var $select = $form.find('#select');
      $select.text($select.data('selected') + ' ' + this.files.length);
      $form.find('#upload').removeClass('hidden');
    });

    $form.on('click', '#select', function(event){
      event.preventDefault();
      $form.find('#files').click();
      return false;
    });

    $form.on('click', '#upload', function(event){
      event.preventDefault();
      $form.submit();
      return false;
    });

    $form.submit(function(event){
      event.preventDefault();
      var files = $(this).find('#files').get(0).files;
      var url = $(this).attr('action');
      var method = $(this).attr('method');
      var token = $form.find('#authenticity_token').val();
      uploadFiles(url, token, method, files, function(pictures) {
        $placeholder = $dialog.find('.picture.placeholder');
        for (var i = 0; i < pictures.length; ++i) {
          var picture = pictures[i];
          var $picture = $placeholder.clone().removeClass('placeholder');
          $picture.find('a.public-link').attr('href', picture.urls.original);
          $picture.find('a.delete-link').attr('href', picture.urls.destroy);
          var $img = $picture.find('img');
          $img.attr('data-id', picture.id);
          $img.attr('data-original', picture.urls.original);
          $img.removeClass('placeholder');
          $img.attr('src', picture.urls.thumb);
          $img.attr('title', $dialog.data('image-title'));
          $picture.find('[title]').tooltip();
          $picture.insertAfter($placeholder);
        }
      });
      return false;
    });

    $dialog.on('click', '.delete-link', function(event){
      event.preventDefault();
      $picture = $(this).closest('.picture');
      $.post($(this).attr('href'), function() {
        $picture.remove();
      });
      return false;
    });

    $dialog.on('click', 'img.placeholder', function(event){
      event.preventDefault();
      $form.find('#files').click();
      return false;
    });


    $dialog.on('click', 'img:not(.placeholder)', function(event){
      event.preventDefault();
      var target = $dialog.data('target');
      var picture = {
        id: $(this).data('id'),
        original: $(this).data('original'),
        thumb: $(this).attr('src')
      };
      $dialog.modal('hide');
      $(target).trigger('picture', picture);
      return false;
    });

    $dialog.modal({show: false});
  });

  $(document).on('show', '#picture-upload-dialog', function(event, options){
    var $dialog = $(this);
    $dialog.data('target', options.target);
    $dialog.data('image-title', options.title);
    $dialog.find('form').attr('action', options.href);
    $dialog.find('img').not('.placeholder').attr('title', options.title);
    $dialog.find('img').not('.placeholder').tooltip();
    $dialog.modal('show');
  });

  $(document).on('click', '.upload-picture', function(event){
    event.preventDefault();
    var options = {
      target: $(this).data('target'),
      href: $(this).attr('href'),
      title: $(this).data('title')
    }
    $('#picture-upload-dialog').trigger('show', options);
    return false;
  });

  $(document).ready(function(){
    $('#public-link-dialog').trigger('setup');
    $('#picture-upload-dialog').trigger('setup');
  });
})();
