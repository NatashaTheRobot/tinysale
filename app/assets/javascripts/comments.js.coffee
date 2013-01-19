# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  display_comment = (data) ->
    $('#submit_comment').slideUp(1000, "easeOutBack" )
    $('#add_review').show(1000)
    stars = 'stars' + data['rating'] + '.png'
    rating = "<div class='star'><img alt="+stars+" src='/assets/" + stars + "'></div>"
    $('.comments').prepend("<div class='comment'><h5>"+ data['title'] + '</h5>'+data['avatar'] + rating + '            ' + data['body'] + "</div>")
    $('#comment_title').val('')
    $('#comment_body').val('')
    false

  calculate_new_average = (rating) ->

  update_average = (rating) ->
    num_comments = $('#rating').data('comments')
    sum = $('#rating').data('rating') * num_comments + rating
    average = sum / (num_comments + 1)
    @display_rating(average)

  $("form#new_comment").bind "ajax:success", (e, data, status, xhr) ->
      display_comment(data)
      update_average(data["rating"])

  $('#star_rating').raty()