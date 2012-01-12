require './spec_helper.coffee'
require '../src/backbone_form_builder.coffee'

describe "Test", ->
  it "tests", ->
    dom.env
      html: "<html><body></body></html>"
      done: ->
    $("body").html("Hola")
    expect($("body").html()).toEqual "Hola"
