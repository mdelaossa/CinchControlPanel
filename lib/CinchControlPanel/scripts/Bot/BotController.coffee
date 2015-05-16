controllers = angular.module('controllers')
controllers.controller 'BotController', [
  '$scope'
  'WebSocketService'
  ($scope, WebSocketService) ->
    $scope.botArgs =
      port: 6667
      ssl:
        use: false
        verify: true
      plugins:
        plugins: []

    $scope.startBots = ->
      WebSocketService.command 'bot', 'start', 'all'

    $scope.stopBots = ->
      WebSocketService.command 'bot', 'stop', 'all'

    $scope.newBot = (values) ->
      WebSocketService.command 'bot', 'new', values
]