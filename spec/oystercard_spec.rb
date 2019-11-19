require "oystercard"

describe Oystercard do

  subject(:oystercard) { Oystercard.new(5) }

  describe "#top_up(money)" do
    it "increases the balance by 5 when top_up(5) is called" do
      expect { subject.top_up(5) }. to change {subject.balance} .by(5)
    end

    context "when starting with a balance at full limit" do
      it "should raise an error when topping up more money" do
        card = Oystercard.new(Oystercard::BALANCE_LIMIT)
        message = "Limit of £#{Oystercard::BALANCE_LIMIT} has been exceeded"
        expect { card.top_up(5) }.to raise_error message
      end
    end
  end

  describe "#deduct(money)" do
    context "when starting with a balance at £20" do
      it "returns a balance of £15 when £5 is deducted" do
        card = Oystercard.new(20)
        expect(card.deduct(5)).to eq 15
      end
    end
  end

  describe "#touch_in" do
    it "sets in_journey to true if successfully touched in" do
      subject.touch_in
      expect(subject.in_journey).to be true
    end

    it "raises an error if you are already in transit" do
      subject.touch_in
      expect { subject.touch_in }.to raise_error "You never touched out"
    end

    it "raises an error if you do not have enough money" do
      message = "You need a minimum of £#{Oystercard::MINIMUM_BALANCE} on your card"
      card = Oystercard.new
      expect { card.touch_in }.to raise_error message
    end
  end

  describe "#touch_out" do
    it "sets in_journey to false if successfully touched out" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to be false
    end

    it "raises an error if not currently in transit" do
      subject.touch_in
      subject.touch_out
      expect { subject.touch_out }.to raise_error "You have not touched in"
    end
  end

  describe "#in_journey?" do
    it "returns true if you are currently in transit" do
      subject.touch_in
      expect(subject.in_journey).to be true
    end
  end

end
