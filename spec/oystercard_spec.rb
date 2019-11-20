require "oystercard"

describe Oystercard do

  subject(:oystercard) { Oystercard.new(5) }
  let(:station) { double :station, name: :Tottenham, zone: 6}
  let(:station2) { double :station2, name: :Mile_end, zone: 2}

  describe "#top_up(money)" do
    it "increases the balance by 5 when top_up(5) is called" do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    context "when starting with a balance at full limit" do
      it "should raise an error when topping up more money" do
        card = Oystercard.new(Oystercard::BALANCE_LIMIT)
        message = "Limit of £#{Oystercard::BALANCE_LIMIT} has been exceeded"
        expect { card.top_up(5) }.to raise_error message
      end
    end
  end

  describe "#touch_in(entry_station)" do

    it "raises an error if you do not have enough money" do
      message = "You need a minimum of £#{Oystercard::MINIMUM_BALANCE} on your card"
      card = Oystercard.new
      expect { card.touch_in(station) }.to raise_error message
    end

  end

  describe "#touch_out(exit_station)" do

    before do
      subject.touch_in(station)
    end
    
    it "checks that balance has been reduced by fare when card touched out" do
      expect {subject.touch_out(station2)}.to change{subject.balance}. by(-1)
    end
    
    it "check if the journey was added to journey history" do
      subject.touch_out(station2)
      expect(subject.journeys_list).to include subject.journey.journey
    end
  end
end
