class StopsController < ApplicationController
  def index
    @stops = Stop.all
    render json: @stops.to_json
  end

  def show
    @stop = Stop.find(params[:id])
    render json: @stop.to_json
  end

  def stop_params
    params.permit(:zone_id, :stop_url)
  end
end
