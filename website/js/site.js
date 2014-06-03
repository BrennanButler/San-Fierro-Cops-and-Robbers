$(document).ready(function() {


   var thebody = $('body').html();
   var $popup = $('a[href$="popup"]'),

         active = false;

         toggle = function(anchor) {
            target = (anchor.data('id')) ? anchor.data('id') : '.popup';
            target = $(target);
            
            if(active) {
               $('body').html('<div class="black-screen"></div>' + thebody);
               target.animate({
                  top: '-350px'
               }, 300, function() {  });
               active = false;

            } 
            else 
            {
               
               target.animate({
                  top: '40px'
               }, 300);
               active = true;
               $('body').html(thebody); 
            }
         };

         $popup.on('click', function() {
            toggle($(this));
            return false;
         });


});