jQuery ->
  $(".products.show").ready ->
    attach_show_handlers()

  attach_show_handlers = ->
    configure_star_ratings()
    configure_payment_form()
    configure_commenting_form()

  # reviews
  configure_commenting_form = ->
    $('#add_review').click ->
      $('#submit_comment').hide()
      $('#submit_review').show()
      #$('#submit_review').slideToggle(1000, "easeOutBack" )

    $('#add_comment').click ->
      $('#submit_review').hide()
      $('#submit_comment').show()
      #$('#submit_comment').slideToggle(1000, "easeOutBack", $(this).css('overflow', 'visible'))

  # ratings
  display_rating = (element, rating, startype) ->
    return if rating is null
    $(element).raty
      readOnly: true
      starHalf: star_half(startype)
      starOff: star_off(startype)
      starOn: star_on(startype)
      score: rating
      round:
        down: 0.25
        full: 0.6
        up: 0.76

  star_half = (startype) ->
    if startype is 'green'
      return '../product/half-star.png'
    else
      return '../product/white-half-star.png'

  star_off = (startype) ->
    if startype is 'green'
      return '../product/black-star.png'
    else
      return '../product/empty-star.png'

  star_on = (startype) ->
    if startype is 'green'
      return '../product/green-star.png'
    else
      return '../product/white-star.png'

  configure_star_ratings = ->
    $('#star_rating').raty(
      hints: ['1 of 5', '2 of 5', '3 of 5', '4 of 5', '5 of 5']
      target: '#number_of_stars_text'
      starOff: '../product/black-star-big.png'
      starOn: '../product/green-star-big.png'
    )
    display_rating('#rating', $('#rating').data('rating'), 'green')
    display_rating('#rating-white', $('#rating-white').data('rating'), 'white')

  display_comment = (comment) ->
    $('.comment_display').prepend(comment)
    false

  update_average = (rating) ->
    return if isNaN(rating)
    num_reviews = $('#rating').data('reviews')
    initial_average = $('#rating').data('rating')
    sum = (initial_average * num_reviews) + rating
    average = sum / (num_reviews + 1)
    display_rating('#rating', average, 'green')
    display_rating('#rating-white', average, 'white')

  clear_and_hide_form = ->
    if $('#submit_comment').is(':visible')
      $('#submit_comment').slideUp(1000, "easeOutBack" )
    else if $('#submit_review').is(':visible')
      $('#submit_review').slideUp(1000, "easeOutBack" )
      $('#add_review').hide()
    $('#name').val('')
    $('#comment').val('')

  $("form#new_comment").bind "ajax:success", (e, comment, status, xhr) ->
    clear_and_hide_form()
    display_comment(comment)
    rating = $('.star_rating', comment).attr('data-rating')
    update_average(parseInt(rating))

  # purchasing
  configure_payment_form = ->
    $('.buy').click ->
      $('.popup').fadeIn 'fast'
      false

    $('.overlay, .close').click ->
      $('.popup').fadeOut()
      false

    $('#card_number').payment('formatCardNumber')
    $('#cvc').payment('formatCardCVC')
    $('#expiration_date').payment('formatCardExpiry')

  $(".products.edit").ready ->
    # need to re-implement twitter bootstrap for this to work...
    $('.wysihtml5').each (i, elem) ->
      $(elem).wysihtml5("image": false)
