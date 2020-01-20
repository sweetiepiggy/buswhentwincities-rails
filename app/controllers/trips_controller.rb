class TripsController < ApplicationController
  def index
    tz = Time.find_zone("America/Chicago")

    departure_time = tz.at(Time.at(params[:departure_time].to_i))
    day_of_week = departure_time.strftime("%A").downcase
    service_ids = Calendar.where(day_of_week => true,
                                 :start_date.lte => departure_time,
                                 :end_date.gt => departure_time).map(&:_id)
    exception_service_ids = CalendarDate.where(date: departure_time.to_date).partition { |cd|
      cd[:exception_type] == 1
    }
    added_service_ids = exception_service_ids[0].map(&:service_id)
    # removed_service_ids = exception_service_ids[1].map(&:service_id)
    removed_service_ids = []

    @trips = Trip.where(block_id: params[:block_id],
                        :service_id.in => (service_ids + added_service_ids - removed_service_ids).uniq,
                        direction_id: params[:direction_id],
                        :trip_headsign => /#{Regexp.quote(params[:description])}$/)

    if @trips.count > 1 and params.key?(:stop_id) then
      fake_datetime = tz.at(departure_time).change(year: 2020, month: 1, day: 1)
      earliest_departure_time = fake_datetime - 90.minutes
      latest_departure_time = fake_datetime + 90.minutes
      stop_times = StopTime.where(:trip_id.in => @trips.map(&:_id),
                                  stop_id: params[:stop_id],
                                  :departure_time.gte => earliest_departure_time,
                                  :departure_time.lte => latest_departure_time)
      trip_ids = stop_times.map(&:trip_id)
      @trips = Trip.where(:_id.in => trip_ids)
    end
      render json: @trips.to_json
  end

  def show
    @trip = Trip.find(params[:id])
    render json: @trip.to_json
  end
end
