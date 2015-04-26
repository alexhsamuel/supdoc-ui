angular.module('supdoc.modules', [
    'ui.router'
])

.config(function ($stateProvider) {
  $stateProvider.state('modules', {
    url: '/modules',
    views: {
      "main": {
          controller: 'ModulesCtrl',
          templateUrl: 'modules/modules.tpl.html'
      }
    },
    data: { pageTitle: 'Modules' }
  })
})

.controller('ModulesCtrl', function ModulesController($scope, $http) {
  $http.get('/assets/doc.json').then(
    function (resp) {
      console.log('got', resp.data)
    },
    function (resp) {
      console.log('error')
    })
})

