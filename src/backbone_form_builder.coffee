class Backbone.FormBuilder extends Backbone.View

  tagName: 'form'

  initialize: ->
    @fields ||= []

  render: ->
    $(@el).html ""
    _.each @fields, (field) =>
      field.render()
      $(@el).append(field.el)

  addField: (field) ->
    field.model = @model
    @fields.push field

class Backbone.FormField extends Backbone.View
  className: 'field'

  initialize: (options = {}) ->
    @name = options.name

  render: ->
    $(@el).html("")
    input = $("<input>").attr('type', 'text').attr('value', @value)
    $(@el).append(input)

  value: ->
    @model.get(@fieldName)
