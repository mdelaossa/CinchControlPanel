app = angular.module 'cinch-controlpanel'

app.factory 'LogService', [
  'WebSocketService'
  (WebSocketService) ->
    log = []
    WebSocketService.subscribe 'log', (message) ->
      if toType(message) == 'string'
        log.push message
      else if toType(message) == 'array'
        Array::push.apply log, message

    return {log: log}
]