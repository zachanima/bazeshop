jQuery ->
  $('nav li:not(.active) ul').hide()
  $('nav > ul > li').click ->
    $('nav li ul').slideUp()
    $(@).children('ul').slideDown()
