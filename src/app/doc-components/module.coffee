(angular.module 'supdoc.doc-components')

.controller 'ModuleCtrl', ($scope) ->
  console.log 'ModuleCtrl ctor'


.directive 'module', ->

  restrict: 'E'
  scope:
    doc: '='
  templateUrl: 'doc-components/module.tpl.html'

