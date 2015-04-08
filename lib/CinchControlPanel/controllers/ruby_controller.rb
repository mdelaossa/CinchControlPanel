module CinchControlPanel
  class RubyController < WebSocketController
    def command command
      begin
        begin
          $stdout = StringIO.new
          result = eval(command) || "nil"
          out = $stdout.string
          return "#{out}\n=> #{result}"
        ensure
          $stdout = STDOUT
        end
      rescue => x
        x.message
      end
    end
  end
end