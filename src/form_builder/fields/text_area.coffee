class Backbone.FormBuilder.Fields.TextArea extends Backbone.FormBuilder.Fields.Base
  input: (name, value) ->
    input = $('<textarea />')
    input.attr('name', name)
    input.attr('type', 'text')
    input.html value
    input
