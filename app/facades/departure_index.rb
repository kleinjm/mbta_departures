# Display methods for the departure index page
class DepartureIndex
  # return departure facades with departures that occur today or later
  def departures
    list =
      Departure.where('scheduled_time >= ?', Time.zone.now.beginning_of_day)
    list.map do |departure|
      DepartureDisplay.new(departure: departure)
    end
  end

  # weekday name
  def today_day
    Time.zone.now.strftime('%A')
  end

  # today's date formatted
  def today_date
    Time.zone.now.strftime('%m-%d-%Y')
  end

  # This would be better handled with JS on the client side for real time
  def curent_time
    Time.zone.now.strftime('%l:%M %p')
  end
end
