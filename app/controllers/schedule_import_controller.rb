class ScheduleImportController < ApplicationController
  # GET index
  # import the latest schedule info and retirect to the departure board
  def index
    csv_path = SCHEDULE_CSV_URI
    CsvImporter.new(uri: csv_path).import

    redirect_to departures_path,
                flash: { notice: t('controller.schedule_import.success') }
  end
end
