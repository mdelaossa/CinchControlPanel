'use strict'

controllers = angular.module('controllers', [])

app = angular.module('cinch-controlpanel', [
  'ui.router'
  'ngWebsocket'
  'controllers'
  'luegg.directives'
])

app.config [
  '$stateProvider'
  '$urlRouterProvider'
  '$locationProvider'
  ($stateProvider, $urlRouterProvider, $locationProvider) ->
    $stateProvider
    .state 'root',
      templateUrl: 'index.html'
    .state 'root.dashboard',
      url: '/'
      views:
        'bot':
          templateUrl: 'bot.html'
          controller: 'BotController'
        'ruby':
          templateUrl: 'ruby.html'
          controller: 'RubyController'
        'log':
          templateUrl: 'log.html'
          controller: 'LogController'

    $urlRouterProvider.otherwise '/'

# $locationProvider.html5Mode(enabled: true)

#TODO: Enable HTML5 mode when done developing
]

app.factory 'TypeService', ()->
  toType: (obj) ->
    {}.toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase()

app.run ['$rootScope', 'TypeService', ($rootScope, TypeService)->
  $rootScope.$on("$stateChangeError", (-> console.log.bind(console)))

  $rootScope.toType = TypeService.toType
]