class TripsController < ApplicationController
  def index
    departure_time = Time.at(params[:departure_time].to_i)
    day_of_week = departure_time.strftime("%A").downcase
    service_ids = Calendar.where(day_of_week => true,
                                 :start_date.lte => departure_time,
                                 :end_date.gte => departure_time).map(&:_id)
    exception_service_ids = CalendarDate.where(date: departure_time.to_date).partition { |cd|
      cd[:exception_type] == 1
    }
    added_service_ids = exception_service_ids[0].map(&:service_id)
    removed_service_ids = exception_service_ids[1].map(&:service_id)

    @trips = Trip.where(block_id: params[:block_id],
                        :service_id.in => (service_ids + added_service_ids - removed_service_ids).uniq,
                        direction_id: params[:direction_id],
                        :trip_headsign => /#{Regexp.quote(params[:description])}$/)

    render json: @trips.to_json
  end

  def show
    @trip = Trip.find(params[:id])
    render json: @trip.to_json
  end
end
