require 'rspec'

RSpec.describe CinchControlPanel::WebSocketMessage do
  subject { CinchControlPanel::WebSocketMessage.new('test', {dude: 'woah'}) }
  hash = {event: 'test', data: {dude: 'woah'}}

  it 'should have an event and data' do
    expect(subject.event).to eq('test')
    expect(subject.data).to eq({dude: 'woah'})
  end

  it 'should be able to return a hash' do
    expect(subject.to_h).to eq(hash)
  end

  it 'should be able to return a json object' do
    expect(subject.to_json).to eq(hash.to_json)
  end

  it 'should return a json object as text' do
    expect(subject.to_s).to eq(hash.to_json.to_s)
  end

end
