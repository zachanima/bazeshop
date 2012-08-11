jQuery ->
  $('table#products tbody').sortable
    axis: 'y'
    update: ->
      $.post $(@).data('update-url'), $(@).sortable('serialize')

  new_image = ->
    id = $(@).data('id') + 1
    alert(id)
    $(@)
      .clone()
      .val('')
      .attr('name', "product[images_attributes][#{id}][image]")
      .data('id', id)
      .removeAttr('class')
      .change(new_image)
      .appendTo('li#images')
    $(@).off()

  $('form.edit_product input[type=file], form.new_product input[type=file]').change(new_image)
