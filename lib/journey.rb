class Journey

  PENALTY_FARE = 6

  MINIMUM_CHARGE = 1

  def initialize
    @active = false
    @previous_journeys = {}
  end

  def active?
    @active
  end

  def begin(station)
    @active = true
    @fare = PENALTY_FARE
    @entry_station = station
  end

  def finish(station)
    @active = false
    @fare = MINIMUM_CHARGE
    @exit_station = station
    self
    @previous_journeys.merge!(entry_station => exit_station)
    @entry_station = nil
    @exit_station = nil
  end

attr_reader :fare

attr_reader :previous_journeys

attr_reader :entry_station

attr_reader :exit_station


end
