jQuery ->
  email_form_toggle = ->
    $('.email_signup').toggle()
    $('.social').toggle()

  submit_email = ( email ) ->
    request = $.ajax(
      url: "/emails"
      type: "POST"
      data: { email: email }
      success: (result) ->
        email_form_toggle()
    )
    request.fail (jqXHR,status) ->
      $('#email-submit').effect('shake', { times:3 }, 200);

  $('#mc-embedded-subscribe').click ->
    submit_email $('#email').val()

  $('.email').keypress (e)->
    code = if e.keyCode then e.keyCode else e.which
    submit_email $('#email').val() if code is 13

