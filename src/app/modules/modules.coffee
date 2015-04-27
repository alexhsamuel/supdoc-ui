(angular.module 'supdoc.modules', ['ui.router'])

.config ($stateProvider) ->
  $stateProvider.state 'modules',
    url: '/ui/modules'
    views:
      main:
        controller: 'ModulesCtrl'
        templateUrl: 'modules/modules.tpl.html'
    data:
      pageTitle: 'Modules'

.controller 'ModulesCtrl', ($scope, api) ->
  $scope.moduleNames = []
  api.modules.getNames().then (names) -> $scope.moduleNames = names

