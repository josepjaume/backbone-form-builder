require '../../test_helper.coffee'
require '../../../src/form_builder.coffee'
require '../../../src/form_builder/form.coffee'
require '../../../src/form_builder/fields.coffee'
require '../../../src/form_builder/fields/password.coffee'

describe "TextField", ->
  beforeEach ->
    @model = new FakeModel
      email: 'fake@fakedomain.com'
    @field = new Backbone.FormBuilder.Fields.Password
    @field.name = 'email'
    @field.model =  @model

  describe "render", ->
    beforeEach ->
      @field.render()

    it "renders the field with its appropiate value", ->
      value = $("input", @field.el).attr('value')
      expect(value).to.equal 'fake@fakedomain.com'

    it "renders the correct field type", ->
      value = $("input", @field.el).attr('type')
      expect(value).to.equal 'password'
