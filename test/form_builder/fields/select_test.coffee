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

      describe "when provided with a single selected value", ->
        beforeEach ->
          @field.renderOptions(@input, 'skiing', @collection)

        it "appends a collection of options to a given dom element", ->
          for element in @collection
            expect($("option[value=#{element}]", @input)).
              to.have.length(1)

        it "has the the provided value selected", ->
          expect(@input.val()).to.contain 'skiing'
          expect(@input.val()).to.have.length 1

      describe "when provided with an array of selected options", ->
        beforeEach ->
          @field.renderOptions(@input, ['skiing', 'coding'], @collection, true)

        it "has multiple provided values selected", ->
          expect(@input.val()).to.contain 'skiing'
          expect(@input.val()).to.contain 'coding'
          expect(@input.val()).to.have.length 2

    describe "when provided with an array of objects", ->
      beforeEach ->
        @collection = [
          {value: 'reading', text: "Reading books"},
          {value: 'skiing', text: "Skiing"},
          {value: 'coding', text: "Coding CoffeeScript"}
        ]
      describe "when provided with a single selected value", ->
        beforeEach ->
          @field.renderOptions(@input, 'skiing', @collection)

        it "appends a collection of options to a given dom element", ->
          for element in @collection
            option = $("option[value=#{element.value}]", @input)
            expect(option).to.have.length(1)
            expect(option.html()).to.equal element.text

        it "has the the provided value selected", ->
          expect(@input.val()).to.contain 'skiing'
          expect(@input.val()).to.have.length 1

      describe "when provided with an array of selected options", ->
        beforeEach ->
          @field.renderOptions(@input, ['skiing', 'coding'], @collection, true)

        it "has multiple provided values selected", ->
          expect(@input.val()).to.contain 'skiing'
          expect(@input.val()).to.contain 'coding'
          expect(@input.val()).to.have.length 2

  describe "render", ->
    beforeEach ->
      @field.options =
        collection: ['reading', 'skiing', 'coding']

    it "renders a select with an appropiate name", ->
      @field.render()
      expect($("select", @field.el).attr('name')).to.equal 'interests'

    describe "when is a single select", ->
      beforeEach ->
        @field.render()

      it "renders the field with its appropiate value", ->
        selected_values = $("select", @field.el).val()
        expect(selected_values).to.contain('skiing')
        expect(selected_values).to.have.length(1)

    describe "when is a multiple select", ->
      beforeEach ->
        @model.set
          interests: ['skiing', 'coding']
        @field.options.multiple = true
        @field.render()

      it "renders the field with its appropiate value", ->
        selected_values = $("select", @field.el).val()
        expect(selected_values).to.contain 'skiing'
        expect(selected_values).to.contain 'coding'
        expect(selected_values).to.have.length 2
