# keep the time stamps in the sample CSVs up to date for testing
module CsvTimeUpdaterSupport
  require 'csv'

  CSV_PWD = "#{Rails.root}/spec/support_files/".freeze
  CSV_FILE_NAME = 'departures_sample.csv'.freeze
  ORIGINAL_FULL_PATH = "#{CSV_PWD}/#{CSV_FILE_NAME}".freeze

  # change all timestamps to times throughout today
  def update_departure_sample_timestamps
    old_file_path = rename_original_file

    build_new_file(old_file_path: old_file_path)
  ensure
    File.delete(old_file_path)
  end

  private

  # rename the original so that there is no name colision when regenerating it
  def rename_original_file
    new_path = "#{CSV_PWD}/old_#{CSV_FILE_NAME}"
    File.rename(ORIGINAL_FULL_PATH, new_path)
    new_path
  end

  # copy the old file to the new one at the original path with an
  # updated timestamp
  def build_new_file(old_file_path:)
    headers = CSV.read(old_file_path, 'r').first

    CSV.open(ORIGINAL_FULL_PATH, 'w') do |csv|
      csv << headers
      CSV.foreach(old_file_path, headers: true).with_index(0) do |row, i|
        row['ScheduledTime'] = i.hour.from_now.strftime('%s')
        csv << row
      end
    end
  end
end
