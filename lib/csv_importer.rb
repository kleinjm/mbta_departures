require 'csv'
require 'open-uri'

# Handles importing for the given schedule CSV URI
class CsvImporter
  LOGGER_PATH = '/log/csv_importer.log'.freeze

  def initialize(uri:)
    @uri = uri
  end

  # download and parse the csv at this URI
  # Headers:
  #   TimeStamp Origin  Trip  Destination ScheduledTime Lateness  Track Status
  def import
    CSV.new(open(uri), headers: :first_row).each_with_index do |line, i|
      begin
        next unless validate_row(line, i)

        create_departure(line)
      rescue => e
        # this is a catch all for all the types of parsing errors that could
        # occur above
        csv_logger.info(
          "Error parsing CSV format incorrect on line #{i}. Error #{e}"
        )
      end
    end
  end

  private

  attr_reader :uri

  # is this a valid row? Logs error and returns false if not
  def validate_row(line, i)
    return true if line.count == 8
    csv_logger.info("Wrong number of CSV columns line #{i}")
    false
  end

  def create_departure(csv_row)
    origin = Stop.find_or_create_by(stop_name: csv_row[1])
    destination = Stop.find_or_create_by(stop_name: csv_row[3])

    departure = build_departure(
      origin: origin, destination: destination, csv_row: csv_row
    )
    save_departure(departure)
  end

  def build_departure(origin:, destination:, csv_row:)
    track_number = csv_row[6].to_i if csv_row[6]

    Departure.new(
      origin: origin,
      trip: csv_row[2], # can be a string like P523
      destination: destination,
      scheduled_time: Time.at(csv_row[4].to_i),
      lateness: csv_row[5].to_i,
      track_number: track_number,
      status: csv_row[7]
    )
  end

  # try to save the departure and log errors if there are any
  def save_departure(departure)
    return if departure.save
    csv_logger.info(
      "Departure failed to save with errors: #{departure.errors.full_messages}"
    )
  end

  def csv_logger
    @_csv_logger ||= Logger.new("#{Rails.root}#{LOGGER_PATH}")
  end
end
