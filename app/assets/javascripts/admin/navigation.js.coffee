jQuery ->
  $('nav li:not(.active) ul').hide()
  $('nav > ul > li > a').click ->
    $('nav li ul').slideUp()
    $(@).parents('li').children('ul').slideDown()
