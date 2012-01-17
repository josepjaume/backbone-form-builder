# backbone.js FormBuilder

## Project Goals

**FormBuilder** is a *backbone.js* extension that aims to make easier the task of rendering forms in a consistent way, as well as providing feedback to the user when necessary. Its main goals are:

* **Extensibility**: Provide field builders for the most used ones, but be extensible easily to support more of them.
* **Nice interface**: The Form Builder API should be nice to work with. Not too smart, not too dumb; should allow to change any aspect without much hassle.
* **Bound to the model**: Attaches to the model, pre-populating its values when necessary.
* **Validations**: Provide model validations, rendering error messages in each field.
    * **Client side**: Supports the most common validations on the client side in order to return feedback to the user as fast as possible.
    * **Backend**: Will try to retrieve validations from the backend when provided in a standard format.

## Syntax

````javascript

form = new Backbone.FormBuilder({
  // The model instance to be bound to
  model:    model,
  // The success function that will be fired when the model can be saved
  success:  function(){
    Backbone.History.navigate('/models/' + this.model.get('id'));
  },
  // (optional): A function to be called if the model save fails
  error: function(){}
);

// This will attach a single text field to the form bound to the 'email'
// property.
form.addField('email', 'password');

// This will attach a single password field to the form bound to the 'password'
// property. Will use a custom function to render the label value. Will
// validate presence.
form.addField('password', 'password',
  {label: function(){ I18n.t('user.password') }
});

// This will create a single text field without any validations.
form.addField('biography', 'text_area'});

````

## Development

Backbone FormBuilder is still purely an **IDEA**. This means that still isn't developed at all.

## Contributions

Appreciated :D
