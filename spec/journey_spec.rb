require "journey"

describe Journey do

  let(:station) { double :station, name: :Tottenham, zone: 6}
  let(:station2) { double :station2, name: :Mile_end, zone: 2}

  describe "#add_entry_station(station)" do
    it "adds an entry station name to journey" do
      subject.add_entry_station(station)
      expect(subject.journey[:entry_station]).to eq station.name
    end

    it "adds an entry station zone to journey" do
      subject.add_entry_station(station)
      expect(subject.journey[:entry_zone]).to eq station.zone
    end
  end

  describe "#add_exit_station(station)" do
    it "adds an exit station name to journey" do
      subject.add_exit_station(station2)
      expect(subject.journey[:exit_station]).to eq station2.name
    end

    it "adds an entry station zone to journey" do
      subject.add_exit_station(station2)
      expect(subject.journey[:exit_zone]).to eq station2.zone
    end
  end
  
  describe "#fare" do
    
    it "Returns the minimum fare" do 
      subject.add_entry_station(station)
      subject.add_exit_station(station2)
      expect(subject.fare).to eq "1"
    end
    
    
    it "Returns the penalty fare" do 
      expect(subject.fare).to eq "6"
    end
  end
end
