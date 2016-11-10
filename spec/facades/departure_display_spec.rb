require 'spec_helper' # no need to load rails for PORO
require './app/facades/departure_display'

describe DepartureDisplay do
  describe '#time' do
    it 'adds the lateness to the scheduled time and formats both' do
      scheduled_time = Time.now
      lateness = 120
      total_time = scheduled_time + lateness

      departure = instance_double(
        'Departure', scheduled_time: scheduled_time, lateness: lateness
      )

      time = DepartureDisplay.new(departure: departure).time
      expect(time).to eq total_time.strftime(DepartureDisplay::TIME_FORMAT)
    end
  end

  describe '#track' do
    it 'displays the placeholder when track number is nil' do
      departure = instance_double('Departure', track_number: nil)
      track = DepartureDisplay.new(departure: departure).track
      expect(track).to eq DepartureDisplay::TRACK_PLACEHOLDER
    end

    it 'displays the track number when present' do
      # test 0 to make sure blank values work
      track_number = 0
      departure = instance_double('Departure', track_number: track_number)
      track = DepartureDisplay.new(departure: departure).track

      expect(track).to eq track_number
    end
  end
end
