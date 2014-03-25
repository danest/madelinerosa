$( document ).ready(function() {
  $('#signup').easyModal();
  $('.btn.red').click(function(e){
    $('#signup').trigger('openModal');
    e.preventDefault();
  });


  $("#card_number").on('keypress change input', function(ev) {
    console.log($.payment.cardType($("#card_number").val()));
    $("#credit-cards").removeClass();
    $("#credit-cards").addClass($.payment.cardType($("#card_number").val()));
  });

});