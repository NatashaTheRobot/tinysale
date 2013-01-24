jQuery ->

  @display_rating = (rating) ->
    return if rating is null
    $('#rating').raty
      readOnly: true
      score: rating
      round:
        down: 0.25
        full: 0.6
        up: 0.76