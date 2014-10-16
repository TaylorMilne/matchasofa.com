//= require './lib/jquery.showmore'


$(document).ready(function() {
  $(window).scroll(function(){
    var scrollPos = $(window).scrollTop();
    if (scrollPos > 0){
      $("header").addClass("collapsed");
    }else{
      $("header").removeClass("collapsed");
    }
  });
});
