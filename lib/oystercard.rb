class Oystercard

  attr_reader :balance, :entry_station

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

  def touch_in(entry_station)
    raise "You need a minimum of £#{Oystercard::MINIMUM_BALANCE} on your card" if insufficient_funds?
    raise "You never touched out" if in_journey?
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out
    raise "You have not touched in" if !in_journey?
    @in_journey = false
    deduct(FARE)
    @entry_station = nil
  end

  private

  def limit_reached?
    @balance >= BALANCE_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end

  def in_journey?
    @entry_station != nil
  end

  def deduct(money)
    @balance -= money
  end

end
