// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .


(function($){
  $.fn.swap = function(id,one,two) {
    var obj = $(id);
    if(obj.html() == one) {
      obj.html(two);
    } else {
      obj.html(one);
    }
  };


  $.fn.slideFadeToggle = function(speed, easing, callback) {
     return this.animate({opacity: 'toggle', height: 'toggle'}, speed, easing, callback);
  };


  $(document).ready(function() {
    $('body').removeClass('no-js').addClass('js');
    $('#about').hide();
    $('#about').insertAfter('#top');
    $('.hide').click(function() {
      $('#about').slideFadeToggle(2000, function(){
        $('.hide').swap($('.hide'),'[+]','[-]');
      });
    });
    $('.schedlink').click( function() {
      $('#sched').show();
      if( $('#sched').css('left') == '-1000px' ) {
        $('#sched').animate({
          left: '20px'
        }, 1500);
      } else {
        $('#sched').animate({
          left: '-1000px'
        }, 1000, function (){ $('#sched').hide(); });
      }
    });

    var mouse_is_inside = false;
    $('#sched').hover(function(){
      mouse_is_inside = true;
    }, function() {
      mouse_is_inside = false;
    });
    $('body').mouseup(function() {
      if (!mouse_is_inside && $('#sched').css('left') == '20px') {
        $('#sched').animate({
            left: '-1000px'
        }, 1000, function (){ $('#sched').hide(); });
      }
    });
    $("a[href*=?u=][href*=&d=]").attr('href', function(i, ref) {
      h = ref.replace( /\?u=([A-Z0-9-_\.\+]+)&d=(((?:[\w-]+\.)+)([A-Z]{2,4}))/i, "$1@$2");
      return "mai"+"lto:"+ h; }).attr('title','');
  });

})(this.jQuery);
