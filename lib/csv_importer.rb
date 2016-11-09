# Handles importing for the given schedule CSV URI
class CsvImporter
  require 'csv'
  require 'open-uri'

  LOCALE = 'lib.csv_importer'.freeze
  LOGGER_PATH = '/log/csv_importer.log'.freeze

  # take in the uri of the csv to be parsed
  def initialize(uri:)
    @uri = uri
  end

  # download and parse the csv at this URI
  # Headers:
  #   TimeStamp Origin  Trip  Destination ScheduledTime Lateness  Track Status
  def import
    CSV.new(open(uri), headers: :first_row).each_with_index do |csv_row, i|
      begin
        create_departure(csv_row: csv_row)
      rescue => e
        # this is a catch all for all the types of parsing errors that could
        # occur above
        csv_logger.info(
          I18n.t('import_exception', scope: LOCALE, row_number: i)
        )
        csv_logger.error(e)
      end
    end
  end

  private

  attr_reader :uri

  # return a departure record created from the given row
  def create_departure(csv_row:)
    origin = Stop.find_or_create_by(stop_name: csv_row[1])
    destination = Stop.find_or_create_by(stop_name: csv_row[3])

    departure = build_departure(
      origin: origin, destination: destination, csv_row: csv_row
    )
    save_departure(departure: departure)
  end

  # return a new unsaved departure from with the given info
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
  def save_departure(departure:)
    return if departure.save
    csv_logger.info(
      I18n.t('departure_save_exception',
             scope: LOCALE, errors: departure.errors.full_messages)
    )
  end

  # return custom logger
  def csv_logger
    @_csv_logger ||= Logger.new("#{Rails.root}#{LOGGER_PATH}")
  end
end
