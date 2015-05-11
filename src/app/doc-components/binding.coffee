(angular.module 'supdoc.doc-components', ['recursion-helper'])

.controller 'BindingDirCtrl', ($scope) ->
  console.log 'BindingDirCtrl ctor'


.directive 'binding', (RecursionHelper) ->

  restrict: 'E'
  scope:
    name: '@'
    doc: '='
  templateUrl: 'doc-components/binding.tpl.html'
  compile: (element) ->
    console.log 'RecursionHelper.compile', element
    RecursionHelper.compile element

