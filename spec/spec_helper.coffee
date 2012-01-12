global.jsdom = require("jsdom").jsdom

global.sinon = require 'sinon'

global.jQuery = require 'jquery'
global.$ = global.jQuery
global._ = require 'underscore'
global.Backbone = (require './support/backbone.js')

global.FakeModel = require './fake_model'
