module CinchControlPanel
  class WebSocketController

    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def action(action, data)
      WebSocketMessage.new(self.class.to_s.split("::").last[/.*(?=Controller)/].downcase, action: action, result: send(action, data)).to_s
    end

  end
end