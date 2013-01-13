# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("form").submit ->
    valuesToSubmit = $(this).serialize()
    #sumbits it to the given url of the form
    # you want a difference between normal and ajax-calls, and json is standard
    $.ajax(
      url: '/comments'
      type: 'POST'
      data: valuesToSubmit
      dataType: "JSON"
    ).success (json) ->
      $('#submit_comment').slideUp(1000, "easeOutBack" )
      $('#add_review').show(1000)
      stars = 'stars' + json['rating'] + '.png'
      rating = "<div class='star'><img alt="+stars+" src='/assets/" + stars + "'></div>"
      $('.comments').prepend("<div class='comment'><h5>"+ json['title'] + '</h5>'+json['avatar'] + rating + '            ' + json['body'] + "</div>")
      $('#comment_title').val('')
      $('#comment_body').val('')
    false # prevents normal behaviour
