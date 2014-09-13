(function(){
  $(document).on('setup', '#posts-wall', function(event){
    event.stopPropagation();
    var $wall = $(this);  
    var options = {
      itemSelector: '.posts-wall-item',
      isFitWidth: true,
      gutter: 30
    };
    $wall.masonry(options);
  });

  $(document).ready(function(){
    $('#posts-wall').trigger('setup');  
  });  
})();

