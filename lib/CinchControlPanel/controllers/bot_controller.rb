module CinchControlPanel
  class BotController < WebSocketController
    def start args
      case args
        when 'all'
          WebServer.bots.each do |bot|
            Thread.new {
              bot.start
            }
          end
        "starting bots"
      end
    end

    def stop args
      case args
        when 'all'
          begin
            WebServer.bots.each do |bot|
              bot.quit "Quitting"
            end
          rescue => x
            "Not all bots stopped" if WebServer.bots.map(&:quitting).include? false
          end
          "stopping bots"
      end
    end
  end
end