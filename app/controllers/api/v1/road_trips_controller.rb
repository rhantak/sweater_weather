class Api::V1::RoadTripsController < ApplicationController
  def index
    render json: RoadTripSerializer.new(RoadTripFacade.new(params[:origin], params[:destination]))
  end
end
