jQuery ->
  # Hide notice after 5 seconds.
  $('div#notice').hide()
  $('div#notice').slideDown()
  $('div#notice').delay(5000)
  $('div#notice').slideUp()

  # Slide down error.
  $('div#error').hide()
  $('div#error').slideDown()
