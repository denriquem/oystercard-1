class Oystercard

  attr_reader :balance, :journeys_list, :journey

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3


  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys_list = []
    @journey = {}
  end

  def top_up(money)
    raise "Limit of £#{BALANCE_LIMIT} has been exceeded" if limit_reached?
    @balance += money
  end

  def touch_in(station)
    raise "You need a minimum of £#{Oystercard::MINIMUM_BALANCE} on your card" if insufficient_funds?
    raise "You never touched out" if in_journey?
    @journey[:entry_station] = station.name
    @journey[:entry_zone] = station.zone
  end

  def touch_out(station)
    raise "You have not touched in" if !in_journey?
    deduct(FARE)
    @journey[:exit_station] = station.name
    @journey[:exit_zone] = station.zone
    @journeys_list << @journey
    @journey = {}
  end

  private

  def limit_reached?
    @balance >= BALANCE_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_BALANCE
  end

  def in_journey?
    @journey[:entry_station] != nil
  end

  def deduct(money)
    @balance -= money
  end

end
