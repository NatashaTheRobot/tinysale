(($) ->
  ready = $.fn.ready
  $.fn.ready = (fn) ->
    if @context is `undefined`

      # The $().ready(fn) case.
      ready fn
    else if @selector
      ready $.proxy(->
        $(@selector, @context).each fn
      , this)
    else
      ready $.proxy(->
        $(this).each fn
      , this)
) jQuery