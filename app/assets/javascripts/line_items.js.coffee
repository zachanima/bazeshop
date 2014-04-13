jQuery ->
  if $('#accept_terms').prop('checked')
    $('#go_to_payment').removeAttr('disabled')
  else
    $('#go_to_payment').attr('disabled', 'disabled')

  $('#accept_terms').change ->
    if $(@).prop('checked')
      $('#go_to_payment').removeAttr('disabled')
    else
      $('#go_to_payment').attr('disabled', 'disabled')
