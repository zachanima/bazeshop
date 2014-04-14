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

  $('#go_to_payment').click ->
    inputs = $('div.fields input[type=text]');
    fields = ''

    for i in [0...inputs.length]
      fields += inputs[i].value + ', '

    $.post ('/shops/' + $('[name=baze_shop]').val() + '/save_fields'),
      fields: fields
