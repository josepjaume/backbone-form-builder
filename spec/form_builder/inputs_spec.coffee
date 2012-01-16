require '../spec_helper.coffee'
require '../../src/form_builder.coffee'
require '../../src/form_builder/inputs.coffee'

describe "Inputs", ->
  beforeEach ->
    global.document = jsdom("<html><body></body></html>")
    global.window = document.createWindow()
    @field = {
      value: -> "fake_value"
      name: 'fake_name'
    }

  describe "Text", ->
    beforeEach ->
      @input = Backbone.FormBuilder.Inputs.Text(@field)

    it "has the correct tag name", ->
      expect($(@input)[0].tagName).toEqual 'INPUT'

    it "has the correct field type", ->
      expect($(@input).attr('type')).toEqual 'text'

    it "returns a text field with a proper name", ->
      expect($(@input).attr('name')).toEqual 'fake_name'

    it "returns a text field with a proper value", ->
      expect($(@input).attr('value')).toEqual 'fake_value'

  describe "TextArea", ->
    beforeEach ->
      @input = Backbone.FormBuilder.Inputs.TextArea(@field)

    it "has the correct tag name", ->
      expect($(@input)[0].tagName).toEqual 'TEXTAREA'

    it "returns a text field with a proper name", ->
      expect($(@input).attr('name')).toEqual 'fake_name'

    it "returns a text field with a proper value", ->
      expect($(@input).html()).toEqual 'fake_value'

