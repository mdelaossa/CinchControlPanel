app = angular.module 'cinch-controlpanel'
app.factory 'WebSocketService', [
  '$websocket'
  '$rootScope'
  ($websocket, $rootScope) ->
    webSocket = $websocket.$new(
      url: 'ws://' + window.location.host + '/websocket'
      reconnect: true
      enqueue: true
      protocols: []).$on('$open', ->
      console.log 'WebSocket opened'
    ).$on('$close', ->
      console.log 'WebSocket closed'
    ).$on('$message', (data) ->
      $rootScope.$digest()
    )
    return {
    subscribe: (event, action) ->
      webSocket.$on event, action
      console.log 'Subscribed to event: ' + event
    unsubscribe: (event) ->
      webSocket.$un event
      console.log 'All handlers for event: ' + event + 'have been destroyed'
    send: (event, data) ->
      webSocket.$emit event, data
    command: (controller, action, data) ->
      webSocket.$emit controller,
        command: action
        data: data
    connect: ->
      webSocket.$open()
    disconnect: ->
      webSocket.$close()
    }
]