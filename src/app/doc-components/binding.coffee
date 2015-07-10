(angular.module 'supdoc.doc-components.binding',
  ['recursion-helper', 'supdoc.api'])

.controller 'BindingDirCtrl', ($scope, $sce, api) ->
  type = api.ref.split($scope.doc.type.$ref) if $scope.doc.type?.$ref
  # True if this is a reference to something elsewhere.
  $scope.isRef = $scope.doc.$ref?
  $scope.isType = type?.module == 'builtins' and type.qualname == 'type'
  $scope.isProperty = type?.module == 'builtins' and type.qualname == 'property'

  isEmpty = (obj) ->
    (Object.getOwnPropertyNames obj).length == 0

  $scope.isRef = () -> angular.isDefined($scope.doc['$ref'])
  $scope.hasDict = () -> $scope.doc.dict and ! isEmpty $scope.doc.dict

  $scope._showContents = false
  $scope.showContents = () -> $scope._showContents
  $scope.toggleShowContents = () ->
    $scope._showContents = ! $scope._showContents

  signature = $scope.doc.signature
  docs = $scope.doc.docs
  if $scope.doc.func?
    # Read through to the wrapped function, e.g. contextmethod, staticethod.
    signature ?= $scope.doc.func.signature
    docs ?= $scope.doc.func.docs

  $scope.isCallable = signature?
  if signature?
    # Format the callable's signature.
    star = false
    sig = []
    for param in signature
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

  # Show the repr if it exists, and this isn't a type or callable.
  $scope.showRepr = () ->
    $scope.doc.repr? and
     ! ($scope.isType or $scope.isCallable or $scope.isProperty)

  $scope.docs = docs

  # Docs bodies contain HTML source.  Anoint them as trusted so that they can
  # be injected into the page.
  # FIXME: Validate.
  if docs?.body?
    docs.bodyHtml = ( ($sce.trustAsHtml p) for p in docs.body )


.directive 'binding', (RecursionHelper) ->

  restrict: 'E'
  scope:
    name: '@'
    doc: '='
  templateUrl: 'doc-components/binding.tpl.html'
  compile: (element) -> RecursionHelper.compile element
