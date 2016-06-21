valid = () ->
  requireds = $('.required').siblings('input[type=text]')
  for i in [0...requireds.length]
    if requireds[i].value.length == 0
      return false

  if $('#accept_terms').prop('checked')
    return true
  else
    return false


jQuery ->
  if $('#accept_terms').prop('checked')
    $('#go_to_payment').removeAttr('disabled')
  else
    $('#go_to_payment').attr('disabled', 'disabled')

  $('input[type=checkbox]').change ->
    if valid()
      $('#go_to_payment').removeAttr('disabled')
    else
      $('#go_to_payment').attr('disabled', 'disabled')

  $('input[type=text]').keyup ->
    if valid()
      $('#go_to_payment').removeAttr('disabled')
    else
      $('#go_to_payment').attr('disabled', 'disabled')

  $('form#payment[action="https://pay.dandomain.dk/proxy.aspx"]').submit ->
    inputs = $('div.fields input[type=text]');
    fields = ''

    for i in [0...inputs.length]
      fields += inputs[i].value + ', '

    $.ajax '/shops/' + $('[name=baze_shop]').val() + '/save_fields',
      type: 'POST'
      data:
        fields: fields
      async: false
      
    true;
