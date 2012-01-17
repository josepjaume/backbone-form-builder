require '../test_helper.coffee'
require '../../src/form_builder.coffee'
require '../../src/form_builder/form.coffee'
require '../../src/form_builder/text_field.coffee'

describe "Field", ->
  beforeEach ->
    @model = new FakeModel
      email: 'fake@fakedomain.com'
    @field = new Backbone.FormBuilder.Field
      name: 'email'
      model: @model

  describe "initialize", ->
    describe "initializes the field name", ->
      it "sets the value provided", ->
        expect(@field.name).to.equal 'email'
      it "defaults to null value", ->
        field = new Backbone.FormBuilder.TextField
        expect(field.name).to.equal undefined

  describe "value", ->
    it "returns the model value for this field", ->
      expect(@field.value()).to.equal 'fake@fakedomain.com'

  describe "render", ->
    it "renders the field with its appropiate value", ->
      @field.render()
      value = $("input", @field.el).attr('value')
      expect(value).to.equal 'fake@fakedomain.com'
