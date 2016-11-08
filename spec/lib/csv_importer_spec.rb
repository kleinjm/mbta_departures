require 'rails_helper'

describe CsvImporter do
  describe '#initialize' do
    it 'initializes with the given uri' do
      expect do
        CsvImporter.new(uri: '/test.csv')
      end.to_not raise_error
    end
  end

  describe '#import' do
    it 'imports all of the records in the file' do
      CsvImporter.new(uri: SCHEDULE_CSV_URI).import

      expect(Departure.count).to eq 4
      expect(Stop.count).to eq 6
    end
  end

  # TODO: test sad paths
end
