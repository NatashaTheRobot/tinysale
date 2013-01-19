jQuery ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5("image": false)

  # reviews

  if $("#add_review").data('user') is 'y'
    $("#sign_up_button").hide()
  else
    $("#add_review").hide()

  $('#add_review').click ->
    $('#add_review').hide()
    $('#submit_comment').slideToggle(1000, "easeOutBack" )

  # ratings

  @display_rating($('#rating').data('rating'))

  # sign in

  $('#sign_in_link').click ->
    $('#sign_up_form').hide()
    $('#sign_in_form').show()

  $("form#sign_in_user").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      $('#sign_up').modal('hide')
      $('#sign_up_button').hide()
      $('#submit_comment').slideToggle(1000, "easeOutBack" )
    else
      alert('failure!')

  # sign up

  $('#sign_up_link').click ->
    $('#sign_up_form').show()
    $('#sign_in_form').hide()

  $("form#sign_up_user").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      $('#sign_up').modal('hide')
      $('#sign_up_button').hide()
      $('#submit_comment').slideToggle(1000, "easeOutBack" )
    else
      alert('failure!')

  # forgot password

  $('#forgot_password_link').click ->
    $('#sign_in_form').hide()
    $('#forgot_password_form').show()

  $('#forgot_signin_link').click ->
    $('#sign_in_form').show()
    $('#forgot_password_form').hide()

  $("form#forgot_password_user").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      $('#sign_up').modal('hide')
    else
      alert('failure!')
