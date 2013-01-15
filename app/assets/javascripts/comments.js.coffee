# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  create_comment = ( comment_data , callback ) ->
    request = $.ajax(
      url: '/comments'
      type: 'POST'
      dataType: 'json'
      data: comment_data
      success: (result) ->
        callback(result)
    )
    request.fail (msg) ->
      alert("Failed to create comment")

  $('#new_comment').submit ->
    comment_data = $(this).serialize()
    create_comment( comment_data , display_comment )

  display_comment = (json) ->
    $('#submit_comment').slideUp(1000, "easeOutBack" )
    $('#add_review').show(1000)
    stars = 'stars' + json['rating'] + '.png'
    rating = "<div class='star'><img alt="+stars+" src='/assets/" + stars + "'></div>"
    $('.comments').prepend("<div class='comment'><h5>"+ json['title'] + '</h5>'+json['avatar'] + rating + '            ' + json['body'] + "</div>")
    $('#comment_title').val('')
    $('#comment_body').val('')
    false