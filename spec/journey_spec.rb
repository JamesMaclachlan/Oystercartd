require 'journey'

describe Journey do

  let(:station){ double :station }

  it 'is not active before touch_in' do
    expect(subject.active?).not_to be true
  end

  it 'is active once touched in' do
    subject.touch_in(station)
    expect(subject).to be_active
  end

  it 'is not active once touched out' do
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject).not_to be_active
  end

end
