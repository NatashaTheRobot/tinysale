jQuery ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5("image": false)

  # reviews

  $('#add_review').click ->
    $('#add_review').hide()
    $('#submit_comment').slideToggle(1000, "easeOutBack" )

  # ratings
  @display_rating($('#rating').data('rating'))