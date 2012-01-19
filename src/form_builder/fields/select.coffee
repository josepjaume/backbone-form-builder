class Backbone.FormBuilder.Fields.Select extends Backbone.FormBuilder.Fields.Base
  input: (name, value, options) ->
    input = $('<select />')
    input.attr('name', name)
    @renderOptions(input, value, options.collection)
    input

  renderOptions: (input, selected, collection) ->
    for element in collection
      if element.value
        value = element.value
        text = element.text
      else
        value = text = element

      option = $("<option />")
      option.attr('value', value)
      option.attr('selected', 'selected') if value == selected
      option.html(text)
      input.append option
