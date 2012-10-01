jQuery ->
  # Add advanced toggle link to form.
  $('form fieldset.advanced').prepend '<a href="#advanced">Advanced</a>'
  $('form fieldset.advanced a[href=#advanced]').siblings('ol').hide()
  $('form fieldset.advanced a[href=#advanced]').click ->
    $(@).siblings('ol').slideToggle()

  # Select all checkboxes.
  $('form thead input[type=checkbox]').change ->
    $(@).parents('table').find('tbody input[type=checkbox]').attr('checked', $(@).is(':checked'))
