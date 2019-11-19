class Oystercard

  attr_reader :balance, :in_journey

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    raise "Limit of £#{BALANCE_LIMIT} has been exceeded" if limit_reached?
    @balance += money
  end

  def touch_in
    raise "You need a minimum of £#{Oystercard::MINIMUM_BALANCE} on your card" if insufficient_funds?
    raise "You never touched out" if in_journey?
    @in_journey = true if !in_journey?
  end

  def touch_out
    raise "You have not touched in" if !in_journey?
    @in_journey = false
    deduct(FARE)
  end

  private

  def limit_reached?
    @balance >= BALANCE_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end

  def in_journey?
    @in_journey
  end

  def deduct(money)
    @balance -= money
  end

end
