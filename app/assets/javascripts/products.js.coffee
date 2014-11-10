jQuery ->
  $('.prev_image').click ->
    current = parseInt($('#current_image').html())

    if current > 1
      --current
      $('#current_image').html(current);
      $('div#product_image a.image').hide()
      $($('div#product_image a.image')[current-1]).show()

  $('.next_image').click ->
    current = parseInt($('#current_image').html())
    total = parseInt($('#total_images').html())

    if current < total
      ++current
      $('#current_image').html(current);
      $('div#product_image a.image').hide()
      $($('div#product_image a.image')[current-1]).show()
