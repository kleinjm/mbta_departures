require 'rails_helper'

describe DeparturesController do
  describe 'GET index' do
    it 'generates a DepartureIndex' do
      get :index
      expect(assigns(:display)).to be_instance_of DepartureIndex
    end
  end
end
