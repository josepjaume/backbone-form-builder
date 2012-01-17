require './test_helper.coffee'
require '../src/form_builder.coffee'
require '../src/form_builder/form.coffee'
require '../src/form_builder/fields/text.coffee'

describe "Integration", ->

  beforeEach ->
    @model = new FakeModel
    @container = $("body")
    @form_builder = new Backbone.FormBuilder.Form
      model: @model
    @container.append(@form_builder.el)

  describe "form without fields", ->
    it "renders an empty form", ->
      @form_builder.render()
      expect(@container.has("form")).to.have.length(1)

  describe "form with fields", ->
    it "renders a form with an input", ->
      @form_builder.addField('email', 'text')
      @form_builder.render()
      expect(@container.has("form")).to.have.length(1)
