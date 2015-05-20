(angular.module 'supdoc', [
  'templates-app'
  'templates-common'
  'supdoc.api'
  'supdoc.doc-components.binding'
  'supdoc.doc-components.module'
  'supdoc.doc-components.ref'
  'supdoc.home'
  'supdoc.about'
  'supdoc.module'
  'supdoc.modules'
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
