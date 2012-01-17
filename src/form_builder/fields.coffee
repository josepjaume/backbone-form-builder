require './inputs.coffee'

Backbone.FormBuilder.Fields ||= {}

class Backbone.FormBuilder.Fields.Base extends Backbone.View
  initialize: (options = {}) ->
    @options = options

  className: 'field'

  render: ->
    $(@el).html ""
    input = @input(@)
    input.attr('id', @inputId())
    $(@el).append @label()
    $(@el).append input

  value: ->
    @model.get(@name)

  input: Backbone.FormBuilder.Inputs.Text

  label: ->
    label = $("<label/>")
    label.attr('for', @inputId())
    if @options.label
      label.html @options.label
    else
      label.html Backbone.FormBuilder.labelMethod(@modelName, @name)
    label

  inputId: ->
    "#{@modelName()}_#{@name}"

  modelName: ->
    @model.constructor.name

  renderErrors: (errors = []) ->
    unless @error_container
      @error_container = $("<div class='errors'/>")
      $(@el).append @error_container

    if errors.length > 0
      @error_container.html errors.join(", ")
    else
      @error_container.remove()
