require 'rspec'

RSpec.describe CinchControlPanel::WebSocketController do
  it 'can list its descendants' do
    expect(CinchControlPanel::WebSocketController.descendants.size).to be > 1
  end

  it 'can receive an action' do
    expect(subject).to respond_to(:action).with(2).arguments
  end

  it 'returns a WebSocketMessage as result for an action' do
    expect(subject).to receive(:test)
    res = subject.action('test', 'testing')
    expect(res).to eq(CinchControlPanel::WebSocketMessage.new('websocket', action: 'test', result: nil).to_s)
  end
end
