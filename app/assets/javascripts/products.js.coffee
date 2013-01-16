jQuery ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5("image": false)

  $('.rating-cancel').remove()

  $('#add_review').click ->
    $('#add_review').hide()
    $('#submit_comment').slideToggle(1000, "easeOutBack" )

  $('#sign_in_link').click ->
    $('#sign_up_form').hide()
    $('#sign_in_form').show()

  $('#sign_up_link').click ->
    $('#sign_up_form').show()
    $('#sign_in_form').hide()

  $('#forgot_password_link').click ->
    $('#sign_in_form').hide()
    $('#forgot_password_form').show()

  $('#forgot_signin_link').click ->
    $('#sign_in_form').show()
    $('#forgot_password_form').hide()

  $("form#sign_in_user").bind "ajax:success", (e, data, status, xhr) ->
    console.log data
    if data.success
      $('#sign_up').modal('hide')
      $('#submit_comment').slideToggle(1000, "easeOutBack" )
    else
      alert('failure!')