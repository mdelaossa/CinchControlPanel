module CinchControlPanel
  require 'singleton'
  class LoggerOutput < Array
    include Singleton

    def puts(obj)
      push(obj)
      if length > 20
        shift
      end
      send_to_websocket obj
      self
    end

    private
    def send_to_websocket(message)
      EM.next_tick { CinchControlPanel::WebServer.settings.sockets.each {|ws| ws.send WebSocketMessage.new('log', message).to_s} }
    end

  end
end