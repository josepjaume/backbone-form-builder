require '../test_helper'
require '../../src/form_builder'
require '../../src/form_builder/form'

describe "FormBuilder", ->

  beforeEach ->
    @model = new FakeModel
    @form_builder = new Backbone.FormBuilder.Form
      model: @model

  describe "initialize", ->
    it "initializes the model", ->
      expect(@form_builder.model).to.equal @model

    it "initializes the fields", ->
      expect(@form_builder.fields.length).to.equal 0

    it "sets the form tag", ->
      expect($(@form_builder.el)[0].tagName).to.equal "FORM"

  describe "render", ->
    describe "when there's no field present", ->
      it "renders nothing", ->
        previous_html = $(@form_builder.el).html()
        @form_builder.render()
        expect($(@form_builder.el).html()).to.equal previous_html

    describe "when there's some fields", ->
      it "renders all of them", ->
        @form_builder.fields = [
          { render: sinon.spy() },
          { render: sinon.spy() },
          { render: sinon.spy() }
        ]

        @form_builder.render()

        for field in @form_builder.fields
          expect(field.render.called).to.be.ok()

      it "appends all of them to the DOM", ->
        @form_builder.fields = [
          { render: (->), el: document.createElement('div')},
          { render: (->), el: document.createElement('div')},
          { render: (->), el: document.createElement('div')}
        ]
        @form_builder.render()

        for field in @form_builder.fields
          expect(
            $(@form_builder.el).has(field.el).length
          ).to.equal 1

    describe "renderErrors", ->
      describe "when provided with some errors", ->
        beforeEach ->
          field1_errors = undefined
          field2_errors = undefined

          field1 =
            name: 'email'
            renderErrors: (errors) ->
              field1_errors = errors

          field2 =
            name: 'name'
            renderErrors: (errors) ->
              field2_errors = errors

          @form_builder.fields = [field1, field2]
          @form_builder.renderErrors
            email: ['1', '2']
            name: ['3', '4']

          @field1_errors = field1_errors
          @field2_errors = field2_errors

        it "renders the correct errors to the first field", ->
          expect(@field1_errors).to.contain '1'
          expect(@field1_errors).to.contain '2'
          expect(@field1_errors).to.not.contain '3'
          expect(@field1_errors).to.not.contain '4'

        it "renders the correct errors to the second field", ->
          expect(@field2_errors).to.contain '3'
          expect(@field2_errors).to.contain '4'
          expect(@field2_errors).to.not.contain '1'
          expect(@field2_errors).to.not.contain '2'


  describe "save", ->
    describe "success callback", ->
      beforeEach ->
        model = @model
        @model.save = (data, options) ->
          options.success.call(model)

      it "calls the success callback when successful", ->
        called = false
        @form_builder.save
          success: ->
            called = true

        expect(called).to.be.ok()

    describe "error callback", ->
      beforeEach ->
        model = @model
        @response = response =
          responseText: '{"errors": {"email": ["mandatory"]}}'

        @model.save = (data, options) ->
          options.error(model, response)

      it "renders the errors", ->
        errors_called = false
        @form_builder.renderErrors = (errors) ->
          expect(errors.email).to.contain "mandatory"
          errors_called = true

        @form_builder.save()
        expect(errors_called).to.be.ok()
