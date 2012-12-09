# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  submit_email = ( email ) ->
    request = $.ajax(
      url: "/emails"
      type: "POST"
      data: { email: email }
      success: (result) ->
        alert("Success")
    )
    request.fail (jqXHR,status) ->
      alert("This did not work")

  $('#submit').click ->
    submit_email $('#email').val()