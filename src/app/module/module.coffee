(angular.module 'supdoc.module', [
  'ui.router'
  'supdoc.api'
  'supdoc.doc-components'
])

.config ($stateProvider) ->
  $stateProvider.state 'module',
    url: '/ui/modules/{module}'
    views:
      main:
        controller: 'ModuleCtrl'
        templateUrl: 'module/module.tpl.html'
    data:
      pageTitle: 'Module'

.controller 'ModuleCtrl', ($scope, $stateParams, api) ->
  $scope.module = $stateParams.module
  $scope.doc = {}
  (api.modules.get $scope.module).then (doc) ->
    $scope.doc = doc

