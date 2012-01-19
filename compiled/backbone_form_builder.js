(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; },
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  Backbone.FormBuilder = {
    labelMethod: function(model_name, attribute) {
      return "" + attribute;
    },
    parseErrors: function(response) {
      return JSON.parse(response);
    }
  };

  Backbone.FormBuilder.Form = (function(_super) {

    __extends(Form, _super);

    function Form() {
      Form.__super__.constructor.apply(this, arguments);
    }

    Form.prototype.tagName = 'form';

    Form.prototype.initialize = function(options) {
      var callbacks,
        _this = this;
      this.fields || (this.fields = []);
      callbacks = {
        success: options.success,
        error: options.error
      };
      return $(this.el).submit(function() {
        _this.save(callbacks);
        return false;
      });
    };

    Form.prototype.formData = function() {
      var field, fields, result, value, _i, _len;
      fields = $(this.el).serializeArray();
      result = {};
      for (_i = 0, _len = fields.length; _i < _len; _i++) {
        field = fields[_i];
        value = field.value || "";
        result[field.name] = value;
      }
      return result;
    };

    Form.prototype.save = function(options) {
      var data, form_builder, key;
      if (options == null) options = {};
      form_builder = this;
      key = this.modelKey();
      data = {};
      data[key] = this.formData();
      return this.model.save(data, {
        success: options.success,
        error: function(model, response) {
          if (options.error) options.error(this.model);
          return form_builder.renderErrors(form_builder.parseErrors(response.responseText));
        }
      });
    };

    Form.prototype.modelKey = function() {
      return this.underscore(this.model.constructor.name);
    };

    Form.prototype.render = function() {
      var field, _i, _len, _ref;
      $(this.el).html("");
      _ref = this.fields;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        field = _ref[_i];
        field.render();
        $(this.el).append(field.el);
      }
      return this;
    };

    Form.prototype.renderErrors = function(errors) {
      var field, _i, _len, _ref, _results;
      _ref = this.fields;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        field = _ref[_i];
        _results.push(field.renderErrors(errors[field.name]));
      }
      return _results;
    };

    Form.prototype.addField = function(name, type, options) {
      var field;
      if (options == null) options = {};
      field = new Backbone.FormBuilder.Fields[this.camelize(type)](options);
      field.model = this.model;
      field.name = name;
      this.fields.push(field);
      return field;
    };

    Form.prototype.camelize = function(string) {
      return string.replace(/(?:^|[-_])(\w)/g, function(_, c) {
        if (c) return c.toUpperCase();
      });
    };

    Form.prototype.underscore = function(string) {
      return string.replace(/([a-z\d])([A-Z]+)/g, '$1_$2').toLowerCase();
    };

    Form.prototype.parseErrors = Backbone.FormBuilder.parseErrors;

    return Form;

  })(Backbone.View);

  (_base = Backbone.FormBuilder).Fields || (_base.Fields = {});

  Backbone.FormBuilder.Fields.Base = (function(_super) {

    __extends(Base, _super);

    function Base() {
      Base.__super__.constructor.apply(this, arguments);
    }

    Base.prototype.initialize = function(options) {
      if (options == null) options = {};
      return this.options = options;
    };

    Base.prototype.className = 'field';

    Base.prototype.render = function() {
      var input;
      $(this.el).html("");
      input = this.input(this.name, this.value(), this.options);
      input.attr('id', this.inputId());
      if (this.options.label !== false) $(this.el).append(this.label());
      return $(this.el).append(input);
    };

    Base.prototype.value = function() {
      return this.model.get(this.name);
    };

    Base.prototype.input = function(name, value) {
      var input;
      input = $('<input />');
      input.attr('name', name);
      input.attr('type', 'text');
      input.attr('value', value);
      return input;
    };

    Base.prototype.label = function() {
      var label;
      label = $("<label/>");
      label.attr('for', this.inputId());
      if (this.options.label) {
        label.html(this.options.label);
      } else {
        label.html(Backbone.FormBuilder.labelMethod(this.modelName, this.name));
      }
      return label;
    };

    Base.prototype.inputId = function() {
      return "" + (this.modelName()) + "_" + this.name;
    };

    Base.prototype.modelName = function() {
      return this.model.constructor.name;
    };

    Base.prototype.renderErrors = function(errors) {
      if (errors == null) errors = [];
      if (!this.error_container) {
        this.error_container = $("<div class='errors'/>");
        $(this.el).append(this.error_container);
      }
      if (errors.length > 0) {
        return this.error_container.html(errors.join(", "));
      } else {
        this.error_container.remove();
        return this.error_container = void 0;
      }
    };

    return Base;

  })(Backbone.View);

  Backbone.FormBuilder.Fields.TextArea = (function(_super) {

    __extends(TextArea, _super);

    function TextArea() {
      TextArea.__super__.constructor.apply(this, arguments);
    }

    TextArea.prototype.input = function(name, value) {
      var input;
      input = $('<textarea />');
      input.attr('name', name);
      input.attr('type', 'text');
      input.html(value);
      return input;
    };

    return TextArea;

  })(Backbone.FormBuilder.Fields.Base);

  Backbone.FormBuilder.Fields.Text = (function(_super) {

    __extends(Text, _super);

    function Text() {
      Text.__super__.constructor.apply(this, arguments);
    }

    Text.prototype.input = function(name, value) {
      var input;
      input = $('<input />');
      input.attr('name', name);
      input.attr('type', 'text');
      input.attr('value', value);
      return input;
    };

    return Text;

  })(Backbone.FormBuilder.Fields.Base);

  Backbone.FormBuilder.Fields.Select = (function(_super) {

    __extends(Select, _super);

    function Select() {
      Select.__super__.constructor.apply(this, arguments);
    }

    Select.prototype.input = function(name, value, options) {
      var input, multiple;
      if (options.multiple) multiple = true;
      input = $('<select />');
      if (multiple) input.attr('multiple', 'multiple');
      input.attr('name', name);
      this.renderOptions(input, value, options.collection, multiple);
      return input;
    };

    Select.prototype.renderOptions = function(input, selected, collection, multiple) {
      var element, option, text, value, _i, _len, _results;
      if (multiple == null) multiple = false;
      if (multiple !== true) selected = [selected];
      _results = [];
      for (_i = 0, _len = collection.length; _i < _len; _i++) {
        element = collection[_i];
        if (element.value) {
          value = element.value;
          text = element.text;
        } else {
          value = text = element;
        }
        option = $("<option />");
        option.attr('value', value);
        if (__indexOf.call(selected, value) >= 0) {
          option.attr('selected', 'selected');
        }
        option.html(text);
        _results.push(input.append(option));
      }
      return _results;
    };

    return Select;

  })(Backbone.FormBuilder.Fields.Base);

  Backbone.FormBuilder.Fields.Password = (function(_super) {

    __extends(Password, _super);

    function Password() {
      Password.__super__.constructor.apply(this, arguments);
    }

    Password.prototype.input = function(name, value) {
      var input;
      input = $('<input />');
      input.attr('name', name);
      input.attr('type', 'password');
      input.attr('value', value);
      return input;
    };

    return Password;

  })(Backbone.FormBuilder.Fields.Base);

}).call(this);
