require 'rspec'

RSpec.describe CinchControlPanel::LoggerOutput do

  context 'the class' do
    subject { CinchControlPanel::LoggerOutput }

    it 'should have only one instance' do
      expect(subject.instance).to eq(CinchControlPanel::LoggerOutput.instance)
      expect{ subject.new }.to raise_error(NoMethodError)
    end

  end

  context 'the instance' do
    subject { CinchControlPanel::LoggerOutput.instance }

    it 'responds to #puts' do
      expect(subject).to respond_to :puts
    end

    it 'should only keep 20 lines' do
      30.times { subject.puts 'a' }
      expect(subject.length).to eq(20)
    end

    it 'sends messages to all websockets objects when #puts' do
      expect(EM).to receive(:next_tick) { Proc }
      subject.puts 'a'
    end

  end

end