class Api::V1::AntipodesController < ApplicationController
  def index
    render json: AntipodeSerializer.new(AntipodeFacade.new(params[:location]))
  end
end
