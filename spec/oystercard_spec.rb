require "oystercard"

describe Oystercard do
  describe "#initilize" do

    it "has a balance of '0' by default" do
      expect(subject.balance).to eq 0
    end

    it "returns balance given when user specifies balance" do
      user_input = rand(5)
      card = Oystercard.new(user_input)
      expect(card.balance).to eq user_input
    end
  end

  describe "#top_up(money)" do
    context "when starting with default balance of 0" do
      it "increases the balance to 5 when top_up(5) is called" do
        subject.top_up(5)
        expect(subject.balance).to eq 5
      end
    end
  end
end
