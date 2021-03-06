jQuery ->
  $('table#products tbody').sortable
    axis: 'y'
    update: ->
      $.post $(@).data('update-url'), $(@).sortable('serialize')

  $('form.edit_product ol#images').sortable
    axis: 'y'
    update: ->
      $.post $(@).data('update-url'), $(@).sortable('serialize')

  $('form.copy_products select').change ->
    $(@).parents('form').submit() if $(@).val() != ''

  $('fieldset.option_sets legend a').click ->
    $(@).parents('legend').siblings('ol').toggle()

  $('fieldset.option_sets legend a').click()

  $('fieldset.option_sets a[href="#all"]').click ->
    $(@).parents('fieldset').find('input[type="checkbox"]').prop('checked', true)

  $('fieldset.option_sets a[href="#none"]').click ->
    $(@).parents('fieldset').find('input[type="checkbox"]').prop('checked', false)

  new_image = ->
    id = $(@).data('id') + 1
    $(@)
      .clone()
      .val('')
      .attr('name', "product[images_attributes][#{id}][image]")
      .data('id', id)
      .removeAttr('class')
      .change(new_image)
      .appendTo('li#image_fields')
    $(@).off()
  $('form.edit_product input[type=file], form.new_product input[type=file]').change(new_image)
