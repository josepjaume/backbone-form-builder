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
    @fields.push field
