module Cinch
  class Bot
    alias_method :old_init, :initialize
    def initialize(&b)
      old_init(&b)
      @loggers << ::CinchControlPanel::WebLogger.new(::CinchControlPanel::LoggerOutput.instance, self)
      ::CinchControlPanel::WebServer.settings.bots << self
    end

    def to_json args=nil
      config.to_h.to_json
    end
  end
end