require 'station'

  describe Station do

    it 'knows its name' do
      expect(subject.name).to eq("Green Lane")
    end

    it 'knows its zone' do
      expect(subject.zone).to eq(3)
    end
    
  end
