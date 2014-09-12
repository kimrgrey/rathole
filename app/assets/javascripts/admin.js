(function(){
  $(document).on('setup', '.admin .dashboard', function(){
    var $dashboard = $(this);
    $dashboard.find('tbody tr').click(function(event){
      event.preventDefault();
      window.location.href = $(this).attr('data-url');
      return false;
    });
    var $placeholder = $("#statistics-flot-placeholder");
    $.get($placeholder.attr('data-url'), function(response){
      $.plot($placeholder, response.values, response.options);
    });
  });

  $(document).ready(function(){
    $('.admin .dashboard').trigger('setup');
  });
})();
