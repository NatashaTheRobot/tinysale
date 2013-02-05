jQuery ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5("image": false)

  # reviews
  $('#add_review').click ->
    $('#submit_comment').hide()
    $('#submit_review').slideToggle(1000, "easeOutBack" )

  $('#add_comment').click ->
    $('#submit_review').hide()
    $('#submit_comment').slideToggle(1000, "easeOutBack" )

  # ratings
  @display_rating('#rating', $('#rating').data('rating'), 'green')
  @display_rating('#rating-white', $('#rating-white').data('rating'), 'white')