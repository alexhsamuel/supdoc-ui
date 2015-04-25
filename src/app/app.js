angular.module('supdoc', [
  'templates-app',
  'templates-common',
  'supdoc.home',
  'supdoc.about',
  'ui.router'
])

.config(function myAppConfig($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.otherwise('/home');
})

.run(function run() {
})

.controller('AppCtrl', function AppCtrl($scope, $location) {
});

