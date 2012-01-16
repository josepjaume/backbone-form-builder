Backbone.FormBuilder ||= {}

require './inputs.coffee'

class Backbone.FormBuilder.TextField extends Backbone.View
  className: 'field'

  initialize: (options = {}) ->
    _.bindAll(@, 'render', 'value', 'input', 'renderErrors')
    @name = options.name
    @model = options.model

  render: ->
    $(@el).html("")
    $(@el).append @input(@)
    @renderErrors()

  value: ->
    @model.get(@name)

  input: Backbone.FormBuilder.Inputs.Text

  renderErrors: ->
