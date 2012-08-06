jQuery ->
  # Handle hiding and showing navigation shop actions.
  $('nav li:not(.active) ul').hide()
  $('nav > ul > li > a').click ->
    $('nav li ul').slideUp()
    $(@).parents('li').children('ul').slideDown()

  # Add advanced toggle link to form.
  $('form fieldset.advanced').prepend '<a href="#advanced">Advanced</a>'
  $('form fieldset.advanced a[href=#advanced]').siblings('ol').hide()
  $('form fieldset.advanced a[href=#advanced]').click ->
    $(@).siblings('ol').slideToggle()

  # Hide notice after 10 seconds
  $('div#notice').hide()
  $('div#notice').slideDown()
  $('div#notice').delay(5000)
  $('div#notice').slideUp()
