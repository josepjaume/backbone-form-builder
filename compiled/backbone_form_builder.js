(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  require('./inputs.coffee');

  Backbone.FormBuilder.Field = (function(_super) {

    __extends(Field, _super);

    function Field() {
      Field.__super__.constructor.apply(this, arguments);
    }

    Field.prototype.initialize = function(options) {
      if (options == null) options = {};
      _.bindAll(this, 'render', 'value', 'input', 'renderErrors');
      this.name = options.name;
      return this.model = options.model;
    };

    Field.prototype.className = 'field';

    Field.prototype.render = function() {
      $(this.el).html("");
      $(this.el).append(this.input(this));
      return this.renderErrors();
    };

    Field.prototype.value = function() {
      return this.model.get(this.name);
    };

    Field.prototype.input = Backbone.FormBuilder.Inputs.Text;

    Field.prototype.renderErrors = function() {};

    return Field;

  })(Backbone.View);

  Backbone.FormBuilder.Form = (function(_super) {

    __extends(Form, _super);

    function Form() {
      Form.__super__.constructor.apply(this, arguments);
    }

    Form.prototype.tagName = 'form';

    Form.prototype.initialize = function() {
      return this.fields || (this.fields = []);
    };

    Form.prototype.render = function() {
      var _this = this;
      $(this.el).html("");
      return _.each(this.fields, function(field) {
        field.render();
        return $(_this.el).append(field.el);
      });
    };

    Form.prototype.addField = function(field) {
      field.model = this.model;
      return this.fields.push(field);
    };

    return Form;

  })(Backbone.View);

  Backbone.FormBuilder.Inputs = {
    Text: function(field) {
      return $('<input />').attr('name', field.name).attr('type', 'text').attr('value', field.value());
    },
    TextArea: function(field) {
      return $("<textarea>").attr('name', field.name).html(field.value());
    }
  };

  require('./field');

  Backbone.FormBuilder.TextField = (function(_super) {

    __extends(TextField, _super);

    function TextField() {
      TextField.__super__.constructor.apply(this, arguments);
    }

    TextField.prototype.input = Backbone.FormBuilder.Inputs.Text;

    return TextField;

  })(Backbone.FormBuilder.Field);

  Backbone.FormBuilder = {};

}).call(this);
