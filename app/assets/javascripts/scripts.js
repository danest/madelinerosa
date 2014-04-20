$( document ).ready(function() {
  $('#signup').easyModal();
  $('.order-button-container .btn.red, .about-us .btn.red').click(function(e){
    $('#signup').trigger('openModal');
    e.preventDefault();
  });


  $("#card_number").on('keypress change input', function(ev) {
    console.log($.payment.cardType($("#card_number").val()));
    $("#credit-cards").removeClass();
    $("#credit-cards").addClass($.payment.cardType($("#card_number").val()));
  });
  $(function() {
    $('a[href*=#]:not([href=#])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
        if (target.length) {
          $('html,body').animate({
            scrollTop: target.offset().top
          }, 1000);
          return false;
        }
      }
    });
  });
});