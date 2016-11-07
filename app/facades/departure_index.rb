# Display methods for the departure index page
class DepartureIndex
  def departures
    list =
      Departure.where('scheduled_time >= ?', Time.zone.now.beginning_of_day)
    list.map do |departure|
      DepartureDisplay.new(departure: departure)
    end
  end

  def today_day
    Time.zone.now.strftime('%A')
  end

  def today_date
    Time.zone.now.strftime('%m-%d-%Y')
  end

  def curent_time
    Time.zone.now.strftime('%l:%M %p')
  end
end
