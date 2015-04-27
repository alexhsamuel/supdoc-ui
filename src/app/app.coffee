(angular.module 'supdoc', [
  'templates-app',
  'templates-common',
  'supdoc.api',
  'supdoc.home',
  'supdoc.about',
  'supdoc.modules',
  'ui.router'
])

.config ($stateProvider, $locationProvider, $urlRouterProvider) ->
  $locationProvider.html5Mode true
  $urlRouterProvider.otherwise '/ui/home'

.run(->)

.controller 'AppCtrl', ($scope, $location) ->
  $scope.$on(
    '$stateChangeSuccess'
    (event, toState, toParams, fromState, fromParams) ->
      $scope.pageTitle = toState.data.pageTitle if toState.data.pageTitle?
  )
