(angular.module 'supdoc.doc-components.ref', ['supdoc.api'])

.controller 'RefDirCtrl', ($scope, api) ->
  split = api.ref.split $scope.ref
  $scope.module = split.module
  $scope.qualname = split.qualname
  $scope.name = split.name

  $scope.sref = 'module({module: "' + module + '"})'
  # FIXME: More specific nav target.
  # $scope.sref += if qualname then '#' + qualname else ''
 

.directive 'ref', () ->
  restrict: 'E'
  scope:
    ref: '='
  templateUrl: 'doc-components/ref.tpl.html'

