class StopTimesController < ApplicationController
  def index
    @stop_times = StopTimes.all
    render json: @stop_times.to_json(:except => :_id)
  end

  def show
    @stop_times = StopTime.where(trip_id: params[:id])
    render json: @stop_times.to_json(:except => :_id)
  end
end
