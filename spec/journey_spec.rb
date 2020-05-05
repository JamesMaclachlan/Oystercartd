require 'journey'
require 'oystercard'

describe Journey do

  let(:station) {double :entry_station}

  it 'is initially not in a journey' do
    expect(subject).not_to be_active
  end

  it 'can begin' do
    subject.begin(station)
    expect(subject).to be_active
  end

  it 'has an empty list of previous journeys' do
    expect(subject.previous_journeys).to be_empty
  end

  context 'whilst in a journey' do

    before do
      subject.begin(station)
    end

    it 'charges the maximum fare by default' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

  end

  context "completed journeys" do

    before do
      subject.begin(station)
      subject.finish(station)
    end

    it 'can finish' do
      expect(subject).not_to be_active
    end

    it 'is charged the correct fare' do
      expect(subject.fare).to eq Journey::MINIMUM_CHARGE
    end

    it 'stores completed journeys in a list' do
      expect(subject.previous_journeys).not_to be_empty
    end

  end
end
