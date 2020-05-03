class Journey

  @active = false

  def active?
    @active
  end

  def touch_in(station)
    @active = true
  end

  def touch_out(station)
    @active = false
  end

end
