require 'oystercard.rb'

describe Oystercard do

  let(:station){ double :station }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  before do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
  end

  it 'will not touch in if below minimum balance' do
    expect{ subject.touch_in(station) }.to raise_error "Insufficient balance to touch in"
  end

  context "all top_up instances" do
    describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'can top up the balance' do
        expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
      end
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
    end
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

  context "journey" do
    before do
      subject.top_up 1
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'can touch in' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'can touch out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it 'stores the entry station' do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    context "completed journeys" do
      before do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      end

      let(:entry_station) { double :station }
      let(:exit_station) { double :station }

      it 'stores the exit station' do
        expect(subject.exit_station).to eq exit_station
      end

      let(:journey){ {entry_station => exit_station} }

      it 'stores a journey' do
      expect(subject.journeys).to include journey
      end
    end
  end

end
