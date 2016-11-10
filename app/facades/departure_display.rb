# Display methods for a departure
class DepartureDisplay
  TRACK_PLACEHOLDER = 'TBD'.freeze
  TIME_FORMAT = '%l:%M %p'.freeze

  attr_reader :departure

  def initialize(departure:)
    @departure = departure
  end

  # the time that the train should arrive accounting for lateness
  def time
    (departure.scheduled_time + departure.lateness).strftime(TIME_FORMAT)
  end

  # return the track number or placeholder
  def track
    departure.track_number || TRACK_PLACEHOLDER
  end
end
