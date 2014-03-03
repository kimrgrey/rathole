(function(){
  function initDashboard() {
    var dashboard = $('.admin .dashboard');
    if (dashboard.length > 0) {
      dashboard.find('tbody tr').click(function(event){
        event.preventDefault();
        window.location.href = $(this).attr('data-url');
        return false;
      });
      var placeholder = $("#statistics-flot-placeholder");
      $.get(placeholder.attr('data-url'), function(response){
        $.plot(placeholder, response.values, response.options);
      });
    }
  }

  $(document).ready(initDashboard);
})();
