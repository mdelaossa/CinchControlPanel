app = angular.module 'cinch-controlpanel'

app.factory 'LogService', [
  'WebSocketService'
  'TypeService'
  (WebSocketService, TypeService) ->
    log = []
    WebSocketService.subscribe 'log', (message) ->
      if TypeService.toType(message) == 'string'
        log.push message
      else if TypeService.toType(message) == 'array'
        Array::push.apply log, message

    return {log: log}
]