require 'rspec'

RSpec.describe CinchControlPanel::WebLogger do
  bot = Cinch::Bot.new
  subject { CinchControlPanel::WebLogger.new(CinchControlPanel::LoggerOutput.instance, bot) }

  it 'should hold an instance to its bot' do
    expect(subject.bot).to eq(bot)
  end

  it 'should be able to log' do
    subject.log 'test'
    expect(CinchControlPanel::LoggerOutput.instance.last).to eq('test')
  end

  it 'should format for web'
end
