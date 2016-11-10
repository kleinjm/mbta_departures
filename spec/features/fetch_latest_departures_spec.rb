require 'rails_helper'
include CsvTimeUpdaterSupport

# Integration spec for fetching latest departure
feature 'fetch latest departures' do
  scenario 'from csv' do
    update_departure_sample_timestamps
    old_departure = create :departure, track_number: 9999

    visit departures_path
    expect(page).to have_content(old_departure.track_number)

    click_link 'Fetch Latest Departures'

    expect(page).to have_no_content(old_departure.track_number)

    # 4 rows in the sample csv
    expect(page.all('.departure-board table tbody tr').count).to eq 4
    # flash notice displays
    expect(page).to have_content I18n.t('controller.schedule_import.success')
  end
end
