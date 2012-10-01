jQuery ->
  $('table#option_sets tbody').sortable
    axis: 'y'
    update: ->
      $.post $(@).data('update-url'), $(@).sortable('serialize')
