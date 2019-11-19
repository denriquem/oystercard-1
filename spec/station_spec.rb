require "station"

describe Station do

  subject(:station) { Station.new(:Tottenham, 6) }

  describe "#initialize" do
    it "has a name on initialization" do
      expect(subject.name).to eq :Tottenham
    end

    it "has a zone on initialization" do
      expect(subject.zone).to eq 6
    end

  end

end
