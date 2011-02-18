class ActivityReport
  
  # Default period to report events
  DEFAULT_PERIOD = 1.day
  
  def initialize(period = nil)
    @period = period || DEFAULT_PERIOD
  end
  
end