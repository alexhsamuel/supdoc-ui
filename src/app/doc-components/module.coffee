(angular.module 'supdoc.doc-components.module', [])

.controller 'ModuleDirCtrl', ($scope) ->
  console.log 'ModuleDirCtrl ctor'


.directive 'module', ->

  restrict: 'E'
  scope:
    doc: '='
  templateUrl: 'doc-components/module.tpl.html'

