module CinchControlPanel
  class BotController < WebSocketController
    require 'recursive-open-struct'

    def new values
      values = RecursiveOpenStruct.new(values)
      bot = Cinch::Bot.new do
        configure do |c|
          c.server          = values.server
          c.port            = values.port
          c.ssl.use         = values.ssl.use
          c.ssl.verify      = values.ssl.verify
          c.nick            = values.nick
          c.realname        = values.realname
          c.user            = values.user
          c.password        = values.password
          c.modes           = values.modes || []
          c.channels        = values.channels || []
          c.plugins.prefix  = values.plugins.prefix
          c.plugins.plugins = values.plugins.plugins.collect { |plugin| class_from_string(plugin) } || []
          #c.plugins.options[Cinch::Plugins::Identify] = {
          #  :username => values.user,
          #  :password => values.nickpass,
          #  :type     => :nickserv
          #}
        end
      end
      "New bot created. Nick: #{bot.config.nick}, Server: #{bot.config.server}:#{bot.config.port}"
    end

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