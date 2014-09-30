(function(){
  $(document).on('setup', '.admin .dashboard', function(event){
    event.stopPropagation();
    var $dashboard = $(this);
    var $placeholder = $("#statistics-flot-placeholder");
    $.get($placeholder.attr('data-url'), function(response){
      $.plot($placeholder, response.values, response.options);
    });
  });

  $(document).ready(function(){
    $('.admin .dashboard').trigger('setup');
  });
})();
