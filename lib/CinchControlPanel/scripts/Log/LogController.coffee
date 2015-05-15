controllers = angular.module('controllers')
controllers.controller 'LogController', [
  '$scope'
  'LogService'
  'WebSocketService'
  ($scope, LogService, WebSocketService) ->
    $scope.log = LogService
]