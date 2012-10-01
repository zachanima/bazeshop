jQuery ->
  # Import users.
  $('form#edit_multiple_users input[type=file]').change ->
    $('form#edit_multiple_users').submit()
