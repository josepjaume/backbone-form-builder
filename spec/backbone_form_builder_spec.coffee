require './spec_helper.coffee'
require '../src/backbone_form_builder.coffee'

describe "FormBuilder", ->

  beforeEach ->
    @model = new FakeModel
    global.document = jsdom("<html><body>HOla</body></html>")
    global.window = document.createWindow()
    @form_builder = new Backbone.FormBuilder
      model: @model

  describe "initialize", ->
    it "initializes the model", ->
      expect(@form_builder.model).toEqual @model

    it "initializes the fields", ->
      expect(@form_builder.fields.length).toEqual 0

    it "sets the form tag", ->
      expect($(@form_builder.el)[0].tagName).toEqual "FORM"

  describe "render", ->
    describe "when there's no field present", ->
      it "renders nothing", ->
        previous_html = $(@form_builder.el).html()
        @form_builder.render()
        expect($(@form_builder.el).html()).toEqual previous_html

    describe "when there's some fields", ->
      it "renders all of them and appends them to the DOM", ->
        @form_builder.fields = [
          { render: sinon.spy() },
          { render: sinon.spy() },
          { render: sinon.spy() }
        ]

        @form_builder.render()

        for field in @form_builder.fields
          expect(field.render.called).toBeTruthy()

      it "appends all of them into the DOM", ->
        @form_builder.fields = [
          { render: (->), el: $("<p>How</p>", document)},
          { render: (->),  el: $("<p>are</p>", document)},
          { render: (->), el: $("<p>you</p>", document)}
        ]
        @form_builder.render()

        expect($(@form_builder.el).text()).toEqual "Howareyou"

    describe "addField", ->
      it "adds a field to the form", ->
        field = {}
        @form_builder.addField field
        expect(_.include(@form_builder.fields, field)).toBeTruthy()
