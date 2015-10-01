# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> # the browser waits until the page has finished loading before running the rest of the code
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content')) #to find our Stripe key from the meta tag that we placed on the page and use that to figure out which Stripe account to connect to
  payment.setupForm() #to run this setupForm function that we see down here
  
payment =
  #when a new order form is submitted, we will disable the submit button so that while we check the card information, the form isn’t going to be accidentally submitted twice. 
  setupForm: ->
    $('#new_order').submit -> 
      $('input[type=submit]').attr('disabled', true)
      #tell Stripe to find the special form fields in our new order form that we labeled with the data-stripe keyword
      Stripe.card.createToken($('#new_order'), payment.handleStripeResponse)
      # jump back to this false statemen after running handleStripeResponse
      false 
  
  handleStripeResponse: (status, response) -> 
  #  if the card information is valid, Stripe will give us back a card token, which is just a unique jumble of letters and numbers. We’ll be able to use this token later on to charge the card
    if status == 200
      $('#new_order').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_order')[0].submit()
 #  if the card information was wrong, then Stripe will give us an error message
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)