Backbone.FormBuilder.Inputs =
  Text: (field) ->
    $('<input />').
      attr('name', field.name).
      attr('type', 'text').
      attr('value', field.value())

  TextArea: (field) ->
    $("<textarea>").
      attr('name', field.name).
      html field.value()
