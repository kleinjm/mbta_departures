require 'rails_helper'

describe Stop do
  describe 'validations' do
    subject { Stop.new(attributes_for(:stop)) }

    it { is_expected.to validate_uniqueness_of(:stop_name) }
  end

  describe '#stop_id' do
    it 'return the id' do
      id = 5
      stop = Stop.new(id: id)
      expect(stop.stop_id).to eq id
    end
  end
end
