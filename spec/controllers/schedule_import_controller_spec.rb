require 'rails_helper'

describe ScheduleImportController do
  describe 'GET index' do
    it 'destroys all existing departures' do
      stub_import
      old_departure = create :departure

      get :index
      expect(Departure.find_by_id(old_departure.id)).to be_nil
    end

    it 'imports new departures' do
      get :index

      expect(Departure.count).to eq 4
    end

    it 'redirects to the departures index' do
      stub_import

      get :index
      expect(response).to redirect_to(departures_path)
    end

    it 'displays a success flash message' do
      stub_import

      get :index
      expect(flash[:notice]).to eq I18n.t('controller.schedule_import.success')
    end
  end

  # do not actually do an import for specs that don't need one
  def stub_import
    importer = instance_double 'CsvImporter'
    expect(importer).to receive(:import)
    expect(CsvImporter).to receive(:new).and_return(importer)
  end
end
