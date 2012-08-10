jQuery ->
  $('table#products tbody').sortable
    axis: 'y'
    update: ->
      $.post $(@).data('update-url'), $(@).sortable('serialize')
