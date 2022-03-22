class StopTimesController < ApplicationController
  def index
    @stop_times = StopTimes.all
    render json: @stop_times.to_json(:except => [:_id, :trip_id])
  end

  def show
    @stop_times = StopTime.where(trip_id: params[:id])
    @stops = Stop.where(:_id.in => @stop_times.map(&:stop_id).map(&:to_s))
    render json: { :stop_times => @stop_times.as_json(:except => [:_id, :trip_id]), :stops => @stops.as_json(:except => [:_id]) }
  end
end
