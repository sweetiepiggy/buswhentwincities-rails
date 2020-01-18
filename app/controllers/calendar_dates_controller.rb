class CalendarDatesController < ApplicationController
  def index
    @calendar_dates = CalendarDate.all
    render json: @calendar_dates.to_json
  end
end
