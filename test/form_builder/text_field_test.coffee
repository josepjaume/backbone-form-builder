require '../test_helper.coffee'
require '../../src/form_builder.coffee'
require '../../src/form_builder/form.coffee'
require '../../src/form_builder/text_field.coffee'

describe "TextField", ->
  beforeEach ->
    @model = new FakeModel
      email: 'fake@fakedomain.com'
    @field = new Backbone.FormBuilder.TextField
      name: 'email'
      model: @model

  describe "render", ->
    it "renders the field with its appropiate value", ->
      @field.render()
      value = $("input", @field.el).attr('value')
      expect(value).to.equal 'fake@fakedomain.com'
