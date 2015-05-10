(angular.module 'supdoc.doc-components', [])

.controller 'BindingDirCtrl', ($scope) ->
  console.log 'BindingDirCtrl ctor'


.directive 'binding', ->

  restrict: 'E'
  scope:
    name: '@'
    doc: '='
  templateUrl: 'doc-components/binding.tpl.html'

