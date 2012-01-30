Backbone.FormBuilder =

  labelMethod: (model_name, attribute) ->
    Backbone.FormBuilder.camelize "#{attribute}"

  parseErrors: (response) ->
    JSON.parse(response).errors

  camelize: (string) ->
    string.replace /(?:^|[-_])(\w)/g, (_, c) ->
      c.toUpperCase() if c

  underscore: (string) ->
    string.replace(/([a-z\d])([A-Z]+)/g, '$1_$2').toLowerCase()

