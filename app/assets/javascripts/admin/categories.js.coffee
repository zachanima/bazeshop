jQuery ->
  $('ol#categories').nestedSortable
    handle: 'a'
    items: 'li'
    toleranceElement: '> a'
    rootID: ''
    update: ->
      $.post $(@).data('update-url'), $(@).sortable('serialize')
