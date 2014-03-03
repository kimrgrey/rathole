(function() {
  function initBugs() {
    $('.bug-in-post').click(function(event){
      event.preventDefault();
      console.log(getSelection());
      return false;
    });
  }

  $(document).ready(initBugs);
})();