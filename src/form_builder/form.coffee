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
    key = @modelKey()
    data = {}
    data[key] = @formData()

    @model.save data,
      success: options.success
      error: (model, response) ->
        options.error(@model) if options.error
        form_builder.renderErrors(form_builder.parseErrors(response.responseText))

  modelKey: ->
    @underscore @model.constructor.name

  render: ->
    $(@el).html ""
    for field in @fields
      field.render()
      $(@el).append(field.el)
    @

  renderErrors: (errors) ->
    for field in @fields
      field.renderErrors(errors[field.name])

  addField: (name, type, options = {}) ->
    field = new Backbone.FormBuilder.Fields[@camelize type](options)
    field.model = @model
    field.name = name
    @fields.push field
    field

  camelize: (string) ->
    string.replace /(?:^|[-_])(\w)/g, (_, c) ->
      c.toUpperCase() if c

  underscore: (string) ->
    string.replace(/([a-z\d])([A-Z]+)/g, '$1_$2').toLowerCase()

  parseErrors: Backbone.FormBuilder.parseErrors
