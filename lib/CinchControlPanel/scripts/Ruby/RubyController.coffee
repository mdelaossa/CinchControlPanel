controllers = angular.module('controllers')
controllers.controller 'RubyController', [
  '$scope'
  'WebSocketService'
  ($scope, WebSocketService) ->
    $scope.sendCommand = (command) ->
      WebSocketService.command 'ruby', 'command', command
      document.querySelector('form[ng-submit=\'sendCommand(command)\'] input[type=\'text\']').select()

    $scope.commandResult = ''

    WebSocketService.subscribe 'ruby', (data) ->
      if data['action'] == 'command'
        $scope.commandResult = data['result']
]