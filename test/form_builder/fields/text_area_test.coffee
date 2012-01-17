require '../../test_helper.coffee'
require '../../../src/form_builder.coffee'
require '../../../src/form_builder/form.coffee'
require '../../../src/form_builder/fields.coffee'
require '../../../src/form_builder/fields/text_area'

describe "TextArea", ->
  beforeEach ->
    @model = new FakeModel
      email: 'fake@fakedomain.com'
    @field = new Backbone.FormBuilder.Fields.TextArea
    @field.name = 'email'
    @field.model =  @model

  describe "render", ->
    beforeEach ->
      @field.render()

    it "renders the field with its appropiate value", ->
      value = $("textarea", @field.el).html()
      expect(value).to.equal 'fake@fakedomain.com'
