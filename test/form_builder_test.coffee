require './test_helper'
require '../src/form_builder'

describe "FormBuilder", ->

  describe "#parseErrors", ->
    beforeEach ->
      @parseErrors = Backbone.FormBuilder.parseErrors

    it "returns the errors", ->
      errors = '{ "errors": { "name" : [ "cannot be blank"] } }'
      expect(@parseErrors(errors, @model)).to.eql({name: ["cannot be blank"]})
