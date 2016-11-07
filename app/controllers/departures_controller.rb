class DeparturesController < ApplicationController
  def index
    @display = DepartureIndex.new
  end
end
