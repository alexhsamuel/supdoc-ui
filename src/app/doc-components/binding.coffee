(angular.module 'supdoc.doc-components.binding', ['recursion-helper'])

.controller 'BindingDirCtrl', ($scope) ->
  console.log $scope.doc.signature

  if $scope.doc.signature
    star = false
    sig = []
    for param in $scope.doc.signature
      sig.push (
        switch param.kind
          when 'VAR_POSITIONAL' then '*' + param.name
          when 'VAR_KEYWORD' then '**' + param.name
          when 'KEYWORD_ONLY' then (
            if not star
              star = true
              sig.push '*'
            param.name
          )
          else
            param.name
      )
    $scope.signature = sig
    console.log 'sig =', sig


.directive 'binding', (RecursionHelper) ->

  restrict: 'E'
  scope:
    name: '@'
    doc: '='
  templateUrl: 'doc-components/binding.tpl.html'
  compile: (element) -> RecursionHelper.compile element
