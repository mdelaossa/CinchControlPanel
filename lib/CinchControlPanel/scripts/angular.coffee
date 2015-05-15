'use strict'

toType = (obj) ->
  {}.toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase()

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
          templateUrl: 'index.html'
          controller: 'LogController'

    $urlRouterProvider.otherwise '/'

  ###$locationProvider.html5Mode({
      enabled: true
  });
  ###

#TODO: Enable HTML5 mode when done developing
]

app.run ['$rootScope', ($rootScope) ->
  $rootScope.$on("$stateChangeError", (-> console.log.bind(console)))
]