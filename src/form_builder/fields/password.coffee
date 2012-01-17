class Backbone.FormBuilder.Fields.Password extends Backbone.FormBuilder.Fields.Base
  input: (name, value) ->
    input = $('<input />')
    input.attr('name', name)
    input.attr('type', 'password')
    input.attr('value', value)
    input
