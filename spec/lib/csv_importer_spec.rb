require 'rails_helper'
require './lib/csv_importer'

describe CsvImporter do
  INVALID_CSV_PATH =
    "#{Rails.root}/spec/support_files/invalid_departures.csv".freeze
  TEST_LOGGER_PATH = "#{Rails.root}/spec/support_files/csv_importer.log".freeze

  describe '#initialize' do
    it 'initializes with the given uri' do
      expect { CsvImporter.new(uri: '/test.csv') }.to_not raise_error
    end
  end

  describe '#import' do
    context 'valid formatted csv' do
      it 'imports all of the records in the file' do
        CsvImporter.new(uri: SCHEDULE_CSV_URI).import

        expect(Departure.count).to eq 4
        expect(Stop.count).to eq 6
      end
    end

    context 'invalid csv' do
      it 'logs exception and does not import row' do
        importer = CsvImporter.new(uri: INVALID_CSV_PATH)
        stub_logger(importer: importer) do
          importer.import

          expect(Departure.count).to be_zero
          expect_logger_to_include(
            text: I18n.t('import_exception',
                         scope: CsvImporter::LOCALE, row_number: 0)
          )
        end
      end

      it 'logs save error and does not import row' do
        importer = CsvImporter.new(uri: INVALID_CSV_PATH)
        stub_logger(importer: importer) do
          importer.import

          expect(Departure.count).to be_zero
          expect_logger_to_include(
            text: I18n.t('departure_save_exception',
                         scope: CsvImporter::LOCALE,
                         errors: ['Status is not included in the list'])
          )
        end
      end
    end
  end

  def stub_logger(importer:)
    raise 'Must provide block' unless block_given?
    log_file = Logger.new(TEST_LOGGER_PATH)
    allow(importer).to receive(:csv_logger).and_return(log_file)
    yield
  ensure
    File.delete(TEST_LOGGER_PATH)
  end

  def expect_logger_to_include(text:)
    log_output = File.read(TEST_LOGGER_PATH)
    expect(log_output).to include text
  end
end
