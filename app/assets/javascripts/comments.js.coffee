# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
#  create_comment = ( comment_data , callback ) ->
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
#
#  $('#new_comment').submit ->
#    comment_data = $(this).serialize()
#    create_comment( comment_data , display_comment )

  display_comment = (data) ->
    $('#submit_comment').slideUp(1000, "easeOutBack" )
    $('#add_review').show(1000)
    stars = 'stars' + data['rating'] + '.png'
    rating = "<div class='star'><img alt="+stars+" src='/assets/" + stars + "'></div>"
    $('.comments').prepend("<div class='comment'><h5>"+ data['title'] + '</h5>'+data['avatar'] + rating + '            ' + data['body'] + "</div>")
    $('#comment_title').val('')
    $('#comment_body').val('')
    false

  $("form#new_comment").bind "ajax:success", (e, data, status, xhr) ->
      display_comment(data)