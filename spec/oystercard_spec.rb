require 'oystercard.rb'

describe Oystercard do

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  before do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
  end

  it 'will not touch in if below minimum balance' do
    expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in"
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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts an amount from the card' do
      expect{ subject.deduct 1 }.to change{subject.balance}.by -1
    end
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end
