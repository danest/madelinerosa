$( document ).ready(function() {
    $('input#card_number').payment('formatCardNumber');
    $('input#cvc').payment('formatCardCVC');
    $('input#exp_year, input#exp_month').payment('restrictNumeric');
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

    var stripeResponseHandler = function(status, response) {
      alert('hello');
      var $form = $('#new_subscription');

      if (response.error) {
        // Show the errors on the form
        $form.find('.payment-errors').text(response.error.message);
        $('input[type=submit]').prop('disabled', false);
         alert(response.error.message);
      } else {
        // token contains id, last4, and card type
        var token = response.id;
        // Insert the token into the form so it gets submitted to the server
        $form.append($('<input type="hidden" name="stripeToken" />').val(token));
        // and submit
        //alert(response.id);
        $form.get(0).submit();
      }
    };

    $("#new_subscription").submit(function(e){
      var $form = $(this);

      // Disable the submit button to prevent repeated clicks
      $('input[type=submit]').prop('disabled', true);

      Stripe.card.createToken($form, stripeResponseHandler);

      // Prevent the form from submitting with the default action
      return false;
    });
});