require '../spec_helper.coffee'
require '../../src/form_builder.coffee'
require '../../src/form_builder/form.coffee'
require '../../src/form_builder/text_field.coffee'

describe "FormField", ->
  beforeEach ->
    @model = new FakeModel
      email: 'fake@fakedomain.com'
    global.document = jsdom("<html><body></body></html>")
    global.window = document.createWindow()
    @field = new Backbone.FormBuilder.TextField
      name: 'email'
      model: @model

  describe "initialize", ->
    describe "initializes the field name", ->
      it "sets the value provided", ->
        expect(@field.name).toEqual 'email'
      it "defaults to null value", ->
        field = new Backbone.FormBuilder.TextField
        expect(field.name).toEqual null

  describe "value", ->
    it "returns the model value for this field", ->
      expect(@field.value()).toEqual 'fake@fakedomain.com'

  describe "render", ->
    it "renders the field with its appropiate value", ->
      @field.render()
      value = $("input", @field.el).attr('value')
      expect(value).toEqual 'fake@fakedomain.com'
