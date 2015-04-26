angular.module('supdoc', [
  'templates-app',
  'templates-common',
  'supdoc.home',
  'supdoc.about',
  'supdoc.modules',
  'ui.router'
])

.config(function myAppConfig($stateProvider, $locationProvider, $urlRouterProvider) {
  $locationProvider.html5Mode(true)
  $urlRouterProvider.otherwise('/home')
})

.run(function run() {
})

.controller('AppCtrl', function AppCtrl($scope, $location) {
  $scope.$on(
    '$stateChangeSuccess', 
    function (event, toState, toParams, fromState, fromParams) {
      if (angular.isDefined(toState.data.pageTitle)) {
        $scope.pageTitle = toState.data.pageTitle
      }
    })
});

