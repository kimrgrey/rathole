$(document).ready(function(){
  var wall = $('#posts-wall');
  if (wall.length > 0) {
    var options = {
      itemSelector: '.posts-wall-item',
      isFitWidth: true,
      gutter: 30
    };
    wall.masonry(options);
  }
});