Backbone.FormBuilder.Inputs =
  Text: (field, options = {}) ->
    input = $('<input />')
    input.attr('name', field.name)
    input.attr('type', 'text')
    input.attr('value', field.value())
    input

  TextArea: (field, options = {}) ->
    input = $("<textarea>")
    input.attr('name', field.name)
    input.html field.value()
    input
