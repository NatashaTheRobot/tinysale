  @login_user = ( data ) ->
    request = $.ajax(
      url: '/users/sign_in.json'
      type: 'POST'
      dataType: 'json'
      data: data
      success: (result) ->
        alert("YAY!!! WE logged in!")
    )
    request.fail (msg) ->
      alert("NOOOOO ... we failed to log in")

  register_user = ->
    alert("HELLO")

  forgot_password = ->
    alert("HELLO")



#    create_comment = ( comment_data , callback ) ->
#    request = $.ajax(
#      url: '/comments'
#      type: 'POST'
#      dataType: 'json'
#      data: comment_data
#      success: (result) ->
#        callback(result)
#    )
#    request.fail (msg) ->
#      alert("Failed to create comment")