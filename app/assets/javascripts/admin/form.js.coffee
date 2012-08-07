jQuery ->
  # Add advanced toggle link to form.
  $('form fieldset.advanced').prepend '<a href="#advanced">Advanced</a>'
  $('form fieldset.advanced a[href=#advanced]').siblings('ol').hide()
  $('form fieldset.advanced a[href=#advanced]').click ->
    $(@).siblings('ol').slideToggle()
