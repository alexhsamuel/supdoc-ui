(angular.module 'supdoc.doc-components.binding',
  ['recursion-helper', 'supdoc.api'])

.controller 'BindingDirCtrl', ($scope, api) ->
  if $scope.doc.signature
    # Format the callable's signature.
    star = false
    sig = []
    for param in $scope.doc.signature
      sig.push (
        switch param.kind
          when 'VAR_POSITIONAL' then '*' + param.name
          when 'VAR_KEYWORD' then '**' + param.name
          when 'KEYWORD_ONLY' then (
            # First time we find a keyword-only param, insert a lone star.
            if not star
              star = true
              sig.push '*'
            param.name
          )
          else
            param.name
      )
    $scope.signature = sig

  # True if this is a reference to something elsewhere.
  $scope.isRef = $scope.doc.$ref?

  if $scope.doc.type?.$ref?
    type = api.ref.split($scope.doc.type.$ref)
    $scope.isType = type.module == 'builtins' and type.qualname == 'type'
  else
    $scope.isType = false

  # Show the repr if it exists, and this isn't a type or callable.
  $scope.showRepr = $scope.doc.repr? and ! ($scope.isType or $scope.signature?)

  # if $scope.doc.type and $scope.doc.type.$ref
  #   parts = $scope.doc.type.$ref.split('/')
  # else
  #   parts = []
  # console.log parts


.directive 'binding', (RecursionHelper) ->

  restrict: 'E'
  scope:
    name: '@'
    doc: '='
  templateUrl: 'doc-components/binding.tpl.html'
  compile: (element) -> RecursionHelper.compile element
