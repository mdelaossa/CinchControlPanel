module CinchControlPanel
  require 'cinch/logger'
  class WebLogger < Cinch::Logger
    attr_reader :bot
    #We want to keep track of the bot it comes from for better output
    def initialize(output, bot)
      @bot = bot
      super(output)
    end
  end
end