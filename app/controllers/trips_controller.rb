class TripsController < ApplicationController
  def index
    # @trips = Trip.where(block_id: params[:block_id],
    #                     :service_id.in => (service_ids + added_service_ids - removed_service_ids).uniq,
    #                     direction_id: params[:direction_id],
    #                     :trip_headsign => /#{Regexp.quote(params[:description])}$/)

    @trips = Trip.where(block_id: params[:block_id],
                        direction_id: params[:direction_id])

    description = params[:description]
    if not description.include?("DELAYED") then
      @trips = @trips.where(:trip_headsign => /#{Regexp.quote(params[:description])}$/)
    end

    if @trips.count > 1 then
      # since we currently only use the shape_id, just return any trip if all shape_ids are same
      if @trips.distinct(:shape_id).count == 1 then
        @trips = @trips.limit(1)
      # try also checking service id (this should always be checked,
      # but doing so seems too strict and fails to find many trips)
      else
        tz = Time.find_zone("America/Chicago")

        departure_time = tz.at(Time.at(params[:departure_time].to_i))
        day_of_week = departure_time.strftime("%A").downcase
        normal_service_ids = Calendar.where(day_of_week => true,
                                            :start_date.lte => departure_time,
                                            :end_date.gt => departure_time).map(&:_id)
        exception_service_ids = CalendarDate.where(date: departure_time.to_date).partition { |cd|
          cd[:exception_type] == 1
        }
        added_service_ids = exception_service_ids[0].map(&:service_id)
        removed_service_ids = exception_service_ids[1].map(&:service_id)
        service_ids = normal_service_ids + added_service_ids - removed_service_ids

        @trips = @trips.where(:service_id.in => service_ids)

        # TODO: refactor this so it's not repeated from above
        if @trips.count > 1 then
          if @trips.distinct(:shape_id).count == 1 then
            @trips = @trips.limit(1)
          # still have too many candidates, so try to narrow down by time/place
          elsif params.key?(:stop_id) then
            fake_datetime = tz.at(departure_time).change(year: 2020, month: 1, day: 1)
            earliest_departure_time = fake_datetime - 90.minutes
            latest_departure_time = fake_datetime + 90.minutes
            stop_times = StopTime.where(:trip_id.in => @trips.map(&:_id),
                                        stop_id: params[:stop_id],
                                        :departure_time.gte => earliest_departure_time,
                                        :departure_time.lte => latest_departure_time)
            trip_ids = stop_times.map(&:trip_id)
            maybe_trips = Trip.where(:_id.in => trip_ids)
            if maybe_trips.count > 1 then
              @trips = maybe_trips
            end
          end
        end
      end
    end

    render json: @trips.to_json
  end

  def show
    @trip = Trip.find(params[:id])
    render json: @trip.to_json
  end
end
