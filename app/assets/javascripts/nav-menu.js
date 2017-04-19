$(document).ready(function(){

  $('.nav-menu-head').click(function() {
    $('.fa-chevron-down').toggleClass("down");

    if($('.nav-menu-head').hasClass('open')){
      $('.nav-menu-body').slideUp( "fast", function() {});
    }else{
      $('.nav-menu-body').slideDown( "fast", function() {});
    }
    $('.nav-menu-head').toggleClass("open");
    // $('.nav-menu-chevron > .fa').toggleClass('fa-chevron-up');
    // $('.nav-menu-chevron > .fa').toggleClass('fa-chevron-down');
  });

});
