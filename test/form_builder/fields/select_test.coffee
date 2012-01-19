require '../../test_helper.coffee'
require '../../../src/form_builder.coffee'
require '../../../src/form_builder/form.coffee'
require '../../../src/form_builder/fields.coffee'
require '../../../src/form_builder/fields/select'

describe "Select", ->
  beforeEach ->
    @model = new FakeModel
      interests: 'skiing'
    @field = new Backbone.FormBuilder.Fields.Select
    @field.name = 'interests'
    @field.model =  @model

  describe "renderOptions", ->
    beforeEach ->
      @input = $("<select/>")

    describe "when provided with a simple array", ->
      beforeEach ->
        @collection = ['reading', 'skiing', 'coding']
        @field.renderOptions(@input, 'skiing', @collection)

      it "appends a collection of options to a given dom element", ->
        for element in @collection
          expect($("option[value=#{element}]", @input)).
            to.have.length(1)

      it "has the the provided value selected", ->
        expect(@input.val()).to.contain 'skiing'
        expect(@input.val()).to.have.length 1

    describe "when provided with an array of objects", ->
      beforeEach ->
        @collection = [
          {value: 'reading', text: "Reading books"},
          {value: 'skiing', text: "Skiing"},
          {value: 'coding', text: "Coding CoffeeScript"}
        ]
        @field.renderOptions(@input, 'skiing', @collection)

      it "appends a collection of options to a given dom element", ->
        for element in @collection
          option = $("option[value=#{element.value}]", @input)
          expect(option).to.have.length(1)
          expect(option.html()).to.equal element.text

      it "has the the provided value selected", ->
        expect(@input.val()).to.contain 'skiing'
        expect(@input.val()).to.have.length 1

  describe "render", ->
    beforeEach ->
      @field.options =
        collection: ['reading', 'skiing', 'coding']
      @field.render()

    it "renders a select with an appropiate name", ->
      expect($("select", @field.el).attr('name')).to.equal 'interests'

    it "renders the field with its appropiate value", ->
      selected_values = $("select", @field.el).val()
      expect(selected_values).to.contain('skiing')
      expect(selected_values).to.have.length(1)
