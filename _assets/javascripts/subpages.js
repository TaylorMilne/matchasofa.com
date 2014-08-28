//= require 'lunr/lunr.min'
//= require 'lunr/mustache'
//= require 'lunr/date.format'
//= require 'lunr/URI.min'
//= require 'lunr/jquery.lunr.search'

//= require './general'
//= require './search'

//= require './lib/jquery.countdown'


$(document).ready(function() {
  $(window).scroll(function(){
    var scrollPos = $(window).scrollTop();
    if (scrollPos > 0){
      $("header").addClass("collapsed");
    }else{
      $("header").removeClass("collapsed");
    }
  });

  $('#clock').countdown('2014/10/15').on('update.countdown', function(event) {
    var $this = $(this).html(event.strftime(''
      + '<span>%-w</span> week%!w '
      + '<span>%-d</span> day%!d '
      + '<span>%H</span> hr '
      + '<span>%M</span> min '
      + '<span>%S</span> sec'));
  });

});
