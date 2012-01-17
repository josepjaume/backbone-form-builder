class Backbone.FormBuilder.Form extends Backbone.View

  tagName: 'form'

  initialize: ->
    @fields ||= []

  render: ->
    $(@el).html ""
    for field in @fields
      field.render()
      $(@el).append(field.el)

  renderErrors: (errors) ->
    for field in @fields
      if field_errors = errors[field.name]
        field.renderErrors(field_errors)

  addField: (name, type, options = {}) ->
    field = new Backbone.FormBuilder.Fields[@camelize type](options)
    field.model = @model
    field.name = name
    @fields.push field
    field

  camelize: (string) ->
    string.replace /(?:^|[-_])(\w)/g, (_, c) ->
      c.toUpperCase() if c

  parseErrors: Backbone.FormBuilder.parseErrors
