jQuery ->
  $('ol.categories').sortable
    axis: 'y'
    update: ->
      $.post $(@).data('update-url'), $(@).sortable('serialize')
