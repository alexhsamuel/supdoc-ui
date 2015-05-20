(angular.module 'supdoc.doc-components.ref', [])

.controller 'RefDirCtrl', ($scope) ->
  parts = $scope.ref.split('/')

  # assert parts[0] == '#'
  # assert parts[1] == 'modules'
  module = parts[2]
  parts = parts[3 ..]

  qualname = null
  while parts.length > 0
    # assert parts[0] == 'dict'
    if qualname is null
      qualname = parts[1]
    else
      qualname += '.' + parts[1]
    parts = parts[2 ..]
  
  $scope.module = module
  $scope.qualname = qualname
  $scope.name = parts[parts.length - 1]
  $scope.sref = 'module({module: "' + module + '"})'
  # FIXME: More specific nav target.
  # $scope.sref += if qualname then '#' + qualname else ''
 

.directive 'ref', () ->
  restrict: 'E'
  scope:
    ref: '='
  templateUrl: 'doc-components/ref.tpl.html'

