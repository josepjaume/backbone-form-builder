require './inputs.coffee'

class Backbone.FormBuilder.Field extends Backbone.View
  initialize: (options = {}) ->
    _.bindAll(@, 'render', 'value', 'input', 'renderErrors')
    @name = options.name
    @model = options.model

  className: 'field'

  render: ->
    $(@el).html("")
    $(@el).append @input(@)
    @renderErrors()

  value: ->
    @model.get(@name)

  input: Backbone.FormBuilder.Inputs.Text

  renderErrors: ->
