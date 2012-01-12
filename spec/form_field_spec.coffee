require './spec_helper.coffee'
require '../src/backbone_form_builder.coffee'

describe "FormField", ->
  beforeEach ->
    @model = new FakeModel
    global.document = jsdom("<html><body></body></html>")
    global.window = document.createWindow()
    @field = new Backbone.FormField

  describe "initialize", ->
    describe "initializes the field name", ->
      it "sets the value provided", ->
        field = new Backbone.FormField
          name: 'email'
        expect(field.name).toEqual 'email'
      it "defaults to null value", ->
        field = new Backbone.FormField
        expect(field.name).toEqual null
