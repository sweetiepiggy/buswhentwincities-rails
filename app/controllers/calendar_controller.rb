class CalendarController < ApplicationController
  def index
    @calendar = Calendar.all
    render json: @calendar.to_json
  end

  def show
    @calendar = Calendar.find(params[:id])
    render json: @calendar.to_json
  end
end
