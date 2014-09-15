(function(){
  $(document).on('picture', '.profile .user-avatar', function(event, picture){
    event.stopPropagation();
    $img = $(this);
    $.post($img.data('url'), { picture_id: picture.id }, function(){
      $('img.avatar').attr('src', picture.thumb);
    });
  });
})();