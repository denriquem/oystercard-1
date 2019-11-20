require 'journey'
class Oystercard

  attr_reader :balance, :journeys_list, :journey

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3


  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys_list = []
    
  end

  def top_up(money)
    raise "Limit of £#{BALANCE_LIMIT} has been exceeded" if limit_reached?
    @balance += money
  end

  def touch_in(station)
    raise "You need a minimum of £#{Oystercard::MINIMUM_BALANCE} on your card" if insufficient_funds?
    @journey = Journey.new
    @journey.add_entry_station(station)
  end

  def touch_out(station)
    @journey.add_exit_station(station)
    @journeys_list << journey.journey
    deduct(FARE)
  end

  private

  def limit_reached?
    @balance >= BALANCE_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end

  def deduct(money)
    @balance -= money
  end

end
