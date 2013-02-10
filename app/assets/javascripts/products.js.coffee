jQuery ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5("image": false)

  # reviews
  $('#add_review').click ->
    $('#submit_comment').hide()
    $('#submit_review').show()
    #$('#submit_review').slideToggle(1000, "easeOutBack" )

  $('#add_comment').click ->
    $('#submit_review').hide()
    $('#submit_comment').show()
    #$('#submit_comment').slideToggle(1000, "easeOutBack", $(this).css('overflow', 'visible'))

  # ratings
  @display_rating('#rating', $('#rating').data('rating'), 'green')
  @display_rating('#rating-white', $('#rating-white').data('rating'), 'white')

  $('#star_rating').raty(
    hints: ['1 of 5', '2 of 5', '3 of 5', '4 of 5', '5 of 5']
    target: '#number_of_stars_text'
    starOff: '../product/black-star-big.png'
    starOn: '../product/green-star-big.png'
  )

  display_comment = (data) ->
    $('#submit_comment').slideUp(1000, "easeOutBack" )
#    $('#add_review').show(1000)
    if data['rating'] is null
      $('.comment_display').prepend("<div class='comment'><h5>"+ data['title'] + '</h5>'+data['avatar'] + '            ' + data['body'] + "</div>")
    else
      stars = 'stars' + data['rating'] + '.png'
      rating = "<div class='star'><img alt="+stars+" src='/assets/product/" + stars + "'></div>"
      $('.comments').prepend("<div class='comment'><h5>"+ data['title'] + '</h5>'+data['avatar'] + rating + '            ' + data['body'] + "</div>")
      $('.review').remove()
    $('#name').val('')
    $('#comment').val('')
    false

  update_average = (rating) ->
    return if rating is null
    num_comments = $('#rating').data('comments')
    sum = $('#rating').data('rating') * num_comments + rating
    average = sum / (num_comments + 1)
    $('#rating').raty
      readOnly: true
      starHalf: '../product/half-star.png'
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

  # purchasing
  $('.buy').click ->
    $('.popup').fadeIn 'fast'
    false

  $('.overlay, .close').click ->
    $('.popup').fadeOut()
    false