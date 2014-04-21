jQuery ->
  $('#user_switch').change ->
    $(@).parent('form').submit()
