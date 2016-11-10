require 'rails_helper'

describe DepartureIndex do
  describe '#departures' do
    it 'returns an array of departure diplays from today or later' do
      create :departure, scheduled_time: 2.days.ago
      upcoming_departure = create :departure, scheduled_time: 1.hour.from_now

      departures = DepartureIndex.new.departures
      expect(departures.count).to eq 1
      expect(departures.first.departure).to eq upcoming_departure
    end
  end
end
