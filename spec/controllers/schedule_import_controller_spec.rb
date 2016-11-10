require 'rails_helper'

describe ScheduleImportController do
  describe 'GET index' do
    it 'imports new departures' do
      old_departure = create :departure

      get :index

      # destroys existing departures
      expect(Departure.find_by_id(old_departure.id)).to be_nil

      expect(Departure.count).to eq 4
      expect(response).to redirect_to(departures_path)
      expect(flash[:notice]).to eq I18n.t('controller.schedule_import.success')
    end
  end
end
