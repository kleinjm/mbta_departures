# Display methods for a departure
class DepartureDisplay
  TRACK_PLACEHOLDER = 'TBD'.freeze

  attr_reader :departure, :trip, :status

  def initialize(departure:)
    @departure = departure
    @trip = departure.trip
    @status = departure.status
  end

  # the time that the train should arrive accounting for lateness
  def time
    (departure.scheduled_time + departure.lateness.seconds).strftime('%l:%M %p')
  end

  # return the track number or placeholder
  def track
    departure.track_number ? departure.track_number : TRACK_PLACEHOLDER
  end

  def destination_name
    departure.destination.stop_name
  end

  def origin_name
    departure.origin.stop_name
  end
end
