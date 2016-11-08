require 'rails_helper'

describe Departure do
  describe 'validations' do
    subject { Departure.new(attributes_for(:departure)) }

    it { should belong_to(:origin) }
    it { should belong_to(:destination) }

    it { is_expected.to validate_presence_of(:origin_id) }
    it { is_expected.to validate_presence_of(:destination_id) }
    it { is_expected.to validate_presence_of(:scheduled_time) }

    it do
      is_expected.to(
        validate_inclusion_of(:status).in_array(Departure::STATUSES)
      )
    end

    it do
      should validate_uniqueness_of(:trip)
        .scoped_to([:origin_id, :destination_id])
    end
  end
end
