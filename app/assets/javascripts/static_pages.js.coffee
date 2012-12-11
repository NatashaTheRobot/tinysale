# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  email_form_toggle = ->
    $('.email').toggle()
    $('.confirm').toggle()
    $('.alert').hide() if $('.alert').is(':visible')

  submit_email = ( email ) ->
    request = $.ajax(
      url: "/emails"
      type: "POST"
      data: { email: email }
      success: (result) ->
        email_form_toggle()
    )
    request.fail (jqXHR,status) ->
      $('.alert').show()
      $('.email').effect('shake', { times:3 }, 200);

  $('#submit').click ->
    submit_email $('#email').val()

  $('.email').keypress (e)->
    code = if e.keyCode then e.keyCode else e.which
    submit_email $('#email').val() if code is 13