module = angular.module 'supdoc.api', []

module.factory 'api', ($http, $q) ->
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
        (n for n of modules).sort()

    get: (name) ->
      if modules[name]
      then $q.when modules[name]
      else (get "/api/modules/#{encodeURI name}").then (data) ->
        module = data.modules[name]
        assert module.name == name, 'got module with wrong name'
        modules[name] = module

  ref:
    
    # Splits a $ref.
    #
    # @return [object]
    #   With keys `module`, `name`, `qualname`.
    split: (ref) ->
      parts = ref.split('/')

      # assert parts[0] == '#'
      # assert parts[1] == 'modules'
      module = parts[2]
      parts = parts[3 ..]
      name = parts[parts.length - 1]

      qualname = null
      while parts.length > 0
        # assert parts[0] == 'dict'
        if qualname is null
          qualname = parts[1]
        else
          qualname += '.' + parts[1]
        parts = parts[2 ..]
      
      {
        module: module,
        qualname: qualname,
        name: name,
      }

