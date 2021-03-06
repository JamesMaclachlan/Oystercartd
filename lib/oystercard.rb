class Oystercard

  MAXIMUM_BALANCE = 90

  MINIMUM_BALANCE = 1

  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    @in_journey = false
    @journeys.merge!(entry_station => exit_station)
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station
  end

  attr_reader :journeys

  attr_reader :balance

  attr_reader :entry_station

  attr_reader :exit_station

  private

  def deduct(amount)
    @balance -= amount
  end

end
