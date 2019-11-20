require "station"

class Journey

  attr_reader :journey

  def initialize
    @journey = {entry_station: nil, entry_zone: nil, exit_station: nil, exit_zone: nil}
  end

  def add_entry_station(station)
    @journey[:entry_station] = station.name
    @journey[:entry_zone] = station.zone
  end

  def add_exit_station(station)
    @journey[:exit_station] = station.name
    @journey[:exit_zone] = station.zone
  end

  def fare
    if @journey[:entry_station] == nil || @journey[:exit_station] == nil
      6
    else
      1
    end
  end
  
  private
  
  def in_journey?
    @journey[:entry_station] != nil
  end
end
