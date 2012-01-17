Backbone.FormBuilder =
  labelMethod: (model_name, attribute) ->
    "#{attribute}"

  parseErrors: (json) ->
    json.errors
