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