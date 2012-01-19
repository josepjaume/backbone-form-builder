class Backbone.FormBuilder.Fields.Select extends Backbone.FormBuilder.Fields.Base
  input: (name, value, options) ->
    multiple = true if options.multiple

    input = $('<select />')
    input.attr('multiple', 'multiple') if multiple
    input.attr('name', name)
    @renderOptions(input, value, options.collection, multiple)
    input

  renderOptions: (input, selected, collection, multiple = false) ->
    selected = [selected] unless multiple == true

    for element in collection
      if element.value
        value = element.value
        text = element.text
      else
        value = text = element

      option = $("<option />")
      option.attr('value', value)
      if value in selected
        option.attr('selected', 'selected')
      option.html(text)
      input.append option
