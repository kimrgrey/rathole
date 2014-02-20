(function(){
  function initDashboard() {
    var dashboard = $('.admin .dashboard');

    dashboard.find('tbody tr').click(function(event){
      event.preventDefault();
      window.location.href = $(this).attr('data-url');
      return false;
    });
  }

  $(document).ready(initDashboard);
})();
