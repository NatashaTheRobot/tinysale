jQuery ->

  @display_rating = (element, rating, startype) ->
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
      return '../product/star-half.png'
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