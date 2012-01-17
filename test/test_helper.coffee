global.jsdom = require("jsdom")
global.window = jsdom.jsdom().createWindow()
global.document = window.document

global.sinon = require 'sinon'
global.expect = require 'expect.js'

global.jQuery = require 'jquery'
global.$ = global.jQuery
global._ = require 'underscore'
global.Backbone = (require './support/backbone.js')

global.FakeModel = require './fake_model'
