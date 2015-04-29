(angular.module 'supdoc.doc-components')

.controller 'ModuleDirCtrl', ($scope) ->
  console.log 'ModuleDirCtrl ctor'


.directive 'module', ->

  restrict: 'E'
  scope:
    doc: '='
  templateUrl: 'doc-components/module.tpl.html'

