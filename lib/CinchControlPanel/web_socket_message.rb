module CinchControlPanel
  class WebSocketMessage
    attr_reader :event, :data

    def initialize(event, data=nil)
      if data
        @event = event
        @data = data
      else
        event = JSON.parse event
        @event = event["event"]
        @data = event["data"]
      end
    end

    def to_h
      {event: @event, data: @data}
    end

    def to_json
      to_h.to_json
    end

    def to_s
      to_json.to_s
    end
  end
end
