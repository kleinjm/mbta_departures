class ScheduleImportController < ApplicationController
  require './lib/csv_importer.rb'

  # GET index
  # import the latest schedule info and retirect to the departure board
  def index
    Departure.destroy_all
    CsvImporter.new(uri: SCHEDULE_CSV_URI).import

    redirect_to departures_path,
                flash: { notice: t('controller.schedule_import.success') }
  end
end
