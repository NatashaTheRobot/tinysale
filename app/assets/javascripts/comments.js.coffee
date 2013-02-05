# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  display_comment = (data) ->
    $('#submit_comment').slideUp(1000, "easeOutBack" )
    $('#add_review').show(1000)
    if data['rating'] is null
      $('.comments').prepend("<div class='comment'><h5>"+ data['title'] + '</h5>'+data['avatar'] + '            ' + data['body'] + "</div>")
    else
      stars = 'stars' + data['rating'] + '.png'
      rating = "<div class='star'><img alt="+stars+" src='/assets/" + stars + "'></div>"
      $('.comments').prepend("<div class='comment'><h5>"+ data['title'] + '</h5>'+data['avatar'] + rating + '            ' + data['body'] + "</div>")
      $('.review').remove()
    $('#comment_title').val('')
    $('#comment_body').val('')
    false

  update_average = (rating) ->
    return if rating is null
    num_comments = $('#rating').data('comments')
    sum = $('#rating').data('rating') * num_comments + rating
    average = sum / (num_comments + 1)
    $('#rating').raty
      readOnly: true
      starHalf: '../product/star-half.png'
      starOff: '../product/black-star.png'
      starOn: '../product/green-star.png'
      score: average
      round:
        down: 0.25
        full: 0.6
        up: 0.76


  $("form#new_comment").bind "ajax:success", (e, data, status, xhr) ->
      display_comment(data)
      update_average(data["rating"])