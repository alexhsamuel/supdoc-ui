angular.module('supdoc.modules', [
    'ui.router'
])

.config(function ($stateProvider) {
  $stateProvider.state('modules', {
    url: '/modules'
  , views: {
      "main": {
        controller: 'ModulesCtrl'
      , templateUrl: 'modules/modules.tpl.html'
      }
    }
  , data: { pageTitle: 'Modules' }
  })
})

.controller('ModulesCtrl', function ModulesController($scope, $http) {
  $http.get('/api/doc').then(
    function (resp) {
      $scope.modules = resp.data.modules
      $scope.moduleNames = Object.keys($scope.modules)
    }
  , function (resp) {
      console.log('error')
    })
})

