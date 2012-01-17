require '../test_helper'
require '../../src/form_builder'
require '../../src/form_builder/form'
require '../../src/form_builder/fields'

describe "Field", ->
  beforeEach ->
    @model = new FakeModel
      email: 'fake@fakedomain.com'
    @field = new Backbone.FormBuilder.Fields.Base
    @field.name = 'email'
    @field.model = @model

  describe "initialize", ->
    describe "initializes the field name", ->
      it "sets the value provided", ->
        expect(@field.name).to.equal 'email'
      it "defaults to null value", ->
        field = new Backbone.FormBuilder.Fields.Base
        expect(field.name).to.equal undefined

  describe "value", ->
    it "returns the model value for this field", ->
      expect(@field.value()).to.equal 'fake@fakedomain.com'

  describe "render", ->
    it "renders the field with its appropiate value", ->
      @field.render()
      value = $("input", @field.el).attr('value')
      expect(value).to.equal 'fake@fakedomain.com'

  describe "renderErrors", ->
    describe "when no errors are supplied", ->
      it "does not render anything special", ->
        @field.render()
        expect($('.errors', @field.el).length).to.equal 0

    describe "when an array of errors is supplied", ->
      beforeEach ->
        @field.render()
        @field.renderErrors(["Error 1", "Error 2"])
        @errors = $('.errors', @field.el)

      it "renders a separate div", ->
        expect(@errors.length).to.equal 1

      it "renders the first error", ->
        expect(@errors.html()).to.contain("Error 1")

      it "renders the second error", ->
        expect(@errors.html()).to.contain("Error 2")

    describe "when there was errors before and now disappeared", ->
      it "should remove them", ->
        @field.render()
        @field.renderErrors(["Error 1", "Error 2"])
        @field.renderErrors([])
        errors = $('.errors', @field.el)
        expect(errors.length).to.equal 0
