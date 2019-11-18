class Oystercard

  attr_reader :balance, :in_journey

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    raise "Limit of £#{BALANCE_LIMIT} has been exceeded" if @balance >= BALANCE_LIMIT
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in
    @in_journey = true if !in_journey?
  end

  def touch_out
    raise "You have not touched in" if !in_journey?
    @in_journey = false
  end

  private

  def in_journey?
    @in_journey
  end

end
