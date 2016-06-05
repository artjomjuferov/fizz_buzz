#= require jquery
#= require jquery_ujs

$(document).on 'ajax:success', 'a', ->
  p = $(this).parent()
  $(p).html 'Favorite'
  return


$(document).on 'ajax:error', 'a', ->
  alert('Such value is not acceptable')
  return