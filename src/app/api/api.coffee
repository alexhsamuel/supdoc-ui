module = angular.module 'supdoc.api', []

module.factory 'api', ($http) ->
  modules = {}
  gotModuleNames = false


  # Helper functions.

  get = (url) -> ($http.get url).then(
    (resp) -> resp.data
    (resp) -> console.error(resp)
  )

  assert = (condition, msg) ->
    if not condition
      console.error msg


  # API object.

  modules:
    getNames: () ->
      if gotModuleNames
      then $q.when (n for n of modules)
      else (get '/api/modules').then (data) ->
        for name of data.modules \
        when name not of modules
          modules[name] = null
        
        gotModuleNames = true
        n for n of modules

    get: (name) ->
      if name of modules
      then $q.when modules[name]
      else (get "/api/modules/#{encodeURI name}").then (data) ->
        module = data.modules[name]
        assert module.name == name, 'got module with wrong name'
        modules[name] = module
