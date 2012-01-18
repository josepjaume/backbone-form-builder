Backbone.FormBuilder =
  labelMethod: (model_name, attribute) ->
    "#{attribute}"

  parseErrors: (response) ->
    JSON.parse response
