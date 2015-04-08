require 'rspec'

RSpec.describe 'Monkey patches' do

  context 'in Cinch::Bot' do
    subject { Cinch::Bot.new }

    it "should respond to #to_json with a json of it's config hash" do
      expect(subject.to_json).to eq(subject.config.to_h.to_json)
    end

    it "should have a single WebLogger that points to itself" do
      logger = subject.loggers.select {|l| l.class == CinchControlPanel::WebLogger}
      expect(logger.size).to be(1)

      logger = logger.first
      expect(logger.bot).to be(subject)
    end

    it "should add itself to WebServer bots" do
      expect(CinchControlPanel::WebServer.bots).to include(subject)
    end

  end

end