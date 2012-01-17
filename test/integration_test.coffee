require './test_helper.coffee'
require '../src/form_builder.coffee'
require '../src/form_builder/form.coffee'
require '../src/form_builder/text_field.coffee'

describe "Integration", ->

  beforeEach ->
    @model = new FakeModel
    @container = $("body")
    @form_builder = new Backbone.FormBuilder.Form
      model: @model
    @container.append(@form_builder.el)

  describe "render", ->
    it "renders an empty form", ->
      @form_builder.render()
      expect(@container.has("form")).to.have.length(1)

  describe "addField", ->
