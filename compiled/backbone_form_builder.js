(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

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

  Backbone.FormBuilder || (Backbone.FormBuilder = {});

  Backbone.FormBuilder.TextField = (function(_super) {

    __extends(TextField, _super);

    function TextField() {
      TextField.__super__.constructor.apply(this, arguments);
    }

    TextField.prototype.className = 'field';

    TextField.prototype.initialize = function(options) {
      if (options == null) options = {};
      _.bindAll(this, 'render', 'value', 'renderInput', 'renderErrors');
      this.name = options.name;
      return this.model = options.model;
    };

    TextField.prototype.render = function() {
      $(this.el).html("");
      this.renderInput();
      return this.renderErrors();
    };

    TextField.prototype.value = function() {
      return this.model.get(this.name);
    };

    TextField.prototype.renderInput = function() {
      this.input = $("<input>", this.el).attr('type', 'text').attr('value', this.value());
      return $(this.el).append(this.input);
    };

    TextField.prototype.renderErrors = function() {};

    return TextField;

  })(Backbone.View);

  Backbone.FormBuilder = {};

}).call(this);
