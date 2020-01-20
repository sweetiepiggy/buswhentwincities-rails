class StopsController < ApplicationController
  def index
    @stops = Stop.all
    render json: @stops.to_json
  end

  def show
    @stop = Stop.find(params[:id])
    render json: @stop.to_json
  end
end
