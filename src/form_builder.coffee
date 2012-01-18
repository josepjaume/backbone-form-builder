Backbone.FormBuilder =
  labelMethod: (model_name, attribute) ->
    "#{attribute}"

  parseErrors: (response) ->
    jQuery.parseJSON response
