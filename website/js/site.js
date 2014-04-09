$(document).ready(function() {
   

   var $popup = $('a[href$="popup"]'),

         active = false;

         toggle = function(anchor) {
            target = (anchor.data('id')) ? anchor.data('id') : '.popup';
            target = $(target);
            if(active) {
               target.animate({
                  top: '-350px'
            }, 300);
            active = false;
            } else {
            target.animate({
                  top: '40px'
            }, 300);
            active = true;
            }
         };

         $popup.on('click', function() {
            toggle($(this));
            return false;
         });


});