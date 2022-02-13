# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'zip'
require 'open-uri'

gtfs_uri = "https://svc.metrotransit.org/mtgtfs/gtfs.zip"

URI.open(gtfs_uri) do |uri_stream|
  Zip::File.open_buffer(uri_stream) do |zipfile|
  # Zip::File.open(Rails.root.join('lib', 'seeds', 'csv_trans_transit_schedule_google_fd.zip')) do |zipfile|

    # service_ids = Hash.new
    # service_id_cnt = 0

    # route_ids = Hash.new
    # route_id_cnt = 0

    # trip_ids = Hash.new
    # trip_id_cnt = 0

    zipfile.each do |file|
      case file.name
      #when 'calendar.txt'
      #  Calendar.delete_all
      #  stream = file.get_input_stream
      #  stream.readline
      #  stream.each do |line|
      #    row = CSV.parse_line(line.force_encoding('UTF-8'))
      #    # service_id_str = row[0]
      #    # if service_ids.key?(service_id_str)
      #    #   service_id = service_ids[service_id_str]
      #    # else
      #    #   service_id = service_id_cnt
      #    #   service_id_cnt += 1
      #    #   service_ids[service_id_str] = service_id
      #    # end
      #    Calendar.create(_id:        row[0],
      #                    monday:     row[1],
      #                    tuesday:    row[2],
      #                    wednesday:  row[3],
      #                    thursday:   row[4],
      #                    friday:     row[5],
      #                    saturday:   row[6],
      #                    sunday:     row[7],
      #                    # dates will be stored in table as utc but are really in local time
      #                    start_date: row[8],
      #                    end_date:   row[9])
      #  end
      #  stream.close
      #when 'calendar_dates.txt'
      #  CalendarDate.delete_all
      #  stream = file.get_input_stream
      #  stream.readline
      #  stream.each do |line|
      #    row = CSV.parse_line(line.force_encoding('UTF-8'))
      #    # service_id_str = row[0]
      #    # if service_ids.key?(service_id_str)
      #    #   service_id = service_ids[service_id_str]
      #    # else
      #    #   service_id = service_id_cnt
      #    #   service_id_cnt += 1
      #    #   service_ids[service_id_str] = service_id
      #    # end
      #    CalendarDate.create(service_id:     row[0],
      #                        # dates will be stored in table as utc but are really in local time
      #                        date:           row[1],
      #                        exception_type: row[2])
      #  end
      #  stream.close
      #when 'routes.txt'
      #  Route.delete_all
      #  stream = file.get_input_stream
      #  stream.readline
      #  stream.each do |line|
      #    row = CSV.parse_line(line.force_encoding('UTF-8'))
      #    # route_id_str = row[0]
      #    # if route_ids.key?(route_id_str)
      #    #   route_id = route_ids[route_id_str]
      #    # else
      #    #   route_id = route_id_cnt
      #    #   route_id_cnt += 1
      #    #   route_ids[route_id_str] = route_id
      #    # end
      #    Route.create(_id:              row[0],
      #                 agency_id:        row[1],
      #                 route_short_name: row[2],
      #                 route_long_name:  row[3],
      #                 route_desc:       row[4],
      #                 route_type:       row[5],
      #                 # route_url:        row[6],
      #                 route_color:      row[7],
      #                 route_text_color: row[8])
      #  end
      #  stream.close
      #when 'shapes.txt'
      #  Shape.delete_all
      #  stream = file.get_input_stream
      #  stream.readline
      #  stream.each do |line|
      #    row = CSV.parse_line(line.force_encoding('UTF-8'))
      #    Shape.create(shape_id:          row[0],
      #                 shape_pt_lat:      row[1],
      #                 shape_pt_lon:      row[2],
      #                 shape_pt_sequence: row[3])
      #  end
      #  stream.close
      #when 'stops.txt'
      #  Stop.delete_all
      #  stream = file.get_input_stream
      #  stream.readline
      #  stream.each do |line|
      #    row = CSV.parse_line(line.force_encoding('UTF-8'))
      #    Stop.create(_id:       row[0],
      #                id:        row[0],
      #                # stop_code: row[1],
      #                stop_name: row[2],
      #                # stop_desc: row[3],
      #                stop_lat:  row[4],
      #                stop_lon:  row[5]
      #                # stop_url:            row[6],
      #                # location_type:       row[7],
      #                # wheelchair_boarding: row[8]
      #                # platform_code        row[9],
      #               )
      #  end
      #  stream.close
      when 'stop_times.txt'
        StopTime.delete_all
        stream = file.get_input_stream
        stream.readline
        stream.each do |line|
          row = CSV.parse_line(line.force_encoding('UTF-8'))
          # trip_id_str = row[0]
          # if trip_ids.key?(trip_id_str)
          #   trip_id = trip_ids[trip_id_str]
          # else
          #   trip_id = trip_id_cnt
          #   trip_id_cnt += 1
          #   trip_ids[trip_id_str] = trip_id
          # end
          timezone_offset = Time.find_zone("America/Chicago").formatted_offset
          StopTime.create(trip_id:        row[0],
                          arrival_time:   "2022-01-01T#{row[1]}#{timezone_offset}",
                          departure_time: "2022-01-01T#{row[2]}#{timezone_offset}",
                          stop_id:        row[3],
                          stop_sequence:  row[4],
                          # pickup_type:    row[5],
                          # drop_off_type:  row[6],
                          timepoint:      row[7])
        end
        stream.close
      #when 'trips.txt'
      #  Trip.delete_all
      #  stream = file.get_input_stream
      #  stream.readline
      #  stream.each do |line|
      #    row = CSV.parse_line(line.force_encoding('UTF-8'))
      #    # route_id_str = row[0]
      #    # if route_ids.key?(route_id_str)
      #    #   route_id = route_ids[route_id_str]
      #    # else
      #    #   route_id = route_id_cnt
      #    #   route_id_cnt += 1
      #    #   route_ids[route_id_str] = route_id
      #    # end
      #    # service_id_str = row[1]
      #    # if service_ids.key?(service_id_str)
      #    #   service_id = service_ids[service_id_str]
      #    # else
      #    #   service_id = service_id_cnt
      #    #   service_id_cnt += 1
      #    #   service_ids[service_id_str] = service_id
      #    # end
      #    # trip_id_str = row[2]
      #    # if trip_ids.key?(trip_id_str)
      #    #   trip_id = trip_ids[trip_id_str]
      #    # else
      #    #   trip_id = trip_id_cnt
      #    #   trip_id_cnt += 1
      #    #   trip_ids[trip_id_str] = trip_id
      #    # end
      #    Trip.create(_id:                   row[2],
      #                route_id:              row[0],
      #                service_id:            row[1],
      #                trip_headsign:         row[3],
      #                direction_id:          row[4],
      #                #direction:             row[5],
      #                block_id:              row[6],
      #                shape_id:              row[7]
      #                # wheelchair_accessible: row[8]
      #                #branch_letter:         row[9]
      #               )
      #  end
      #  stream.close
      end
    end
  end
end
