require '../test_helper.coffee'
require '../../src/form_builder.coffee'
require '../../src/form_builder/inputs.coffee'

describe "Inputs", ->
  beforeEach ->
    @field = {
      value: -> "fake_value"
      name: 'fake_name'
    }

  describe "Text", ->
    beforeEach ->
      @input = Backbone.FormBuilder.Inputs.Text(@field)

    it "has the correct tag name", ->
      expect($(@input)[0].tagName).to.equal 'INPUT'

    it "has the correct field type", ->
      expect($(@input).attr('type')).to.equal 'text'

    it "returns a text field with a proper name", ->
      expect($(@input).attr('name')).to.equal 'fake_name'

    it "returns a text field with a proper value", ->
      expect($(@input).attr('value')).to.equal 'fake_value'

  describe "TextArea", ->
    beforeEach ->
      @input = Backbone.FormBuilder.Inputs.TextArea(@field)

    it "has the correct tag name", ->
      expect($(@input)[0].tagName).to.equal 'TEXTAREA'

    it "returns a text field with a proper name", ->
      expect($(@input).attr('name')).to.equal 'fake_name'

    it "returns a text field with a proper value", ->
      expect($(@input).html()).to.equal 'fake_value'
