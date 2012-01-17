class Backbone.FormBuilder.Form extends Backbone.View

  tagName: 'form'

  initialize: (options) ->
    @fields ||= []
    callbacks =
      success: options.success
      error: options.error

    $(@el).submit =>
      @save(callbacks)
      false

  formData: ->
    fields = $(@el).serializeArray()
    result = {}
    for field in fields
      value = field.value || ""
      result[field.name] = value
    result

  save: (options = {}) ->
    form_builder = @
    @model.set @formData()
    @model.save
      success: options.success
      error: (model, response) ->
        options.error(@model) if options.error
        form_builder.renderErrors(response)

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
