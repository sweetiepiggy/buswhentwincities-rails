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

gtfs_uri = "https://resources.gisdata.mn.gov/pub/gdrs/data/pub/us_mn_state_metc/trans_transit_schedule_google_fd/csv_trans_transit_schedule_google_fd.zip"

URI.open(gtfs_uri) do |uri_stream|
  Zip::File.open_buffer(uri_stream) do |zipfile|
    # Zip::File.open(Rails.root.join('lib', 'seeds', 'csv_trans_transit_schedule_google_fd.zip')) do |zipfile|
    zipfile.each do |file|
      case file.name
      when 'calendar.txt'
        stream = file.get_input_stream
        stream.readline
        stream.each do |line|
          row = CSV.parse_line(line.force_encoding('UTF-8'))
          Calendar.create(_id:        row[0],
                          monday:     row[1],
                          tuesday:    row[2],
                          wednesday:  row[3],
                          thursday:   row[4],
                          friday:     row[5],
                          saturday:   row[6],
                          sunday:     row[7],
                          start_date: row[8],
                          end_date:   row[9])
        end
        stream.close
      when 'calendar_dates.txt'
        stream = file.get_input_stream
        stream.readline
        stream.each do |line|
          row = CSV.parse_line(line.force_encoding('UTF-8'))
          CalendarDate.create(service_id:     row[0],
                              date:           row[1],
                              exception_type: row[2])
        end
        stream.close
      when 'routes.txt'
        stream = file.get_input_stream
        stream.readline
        stream.each do |line|
          row = CSV.parse_line(line.force_encoding('UTF-8'))
          Route.create(_id:              row[0],
                       agency_id:        row[1],
                       route_short_name: row[2],
                       route_long_name:  row[3],
                       route_desc:       row[4],
                       route_type:       row[5],
                       # route_url:        row[6],
                       route_color:      row[7],
                       route_text_color: row[8])
        end
        stream.close
      when 'shapes.txt'
        stream = file.get_input_stream
        stream.readline
        stream.each do |line|
          row = CSV.parse_line(line.force_encoding('UTF-8'))
          Shape.create(shape_id:          row[0],
                       shape_pt_lat:      row[1],
                       shape_pt_lon:      row[2],
                       shape_pt_sequence: row[3])
        end
        stream.close
      when 'stops.txt'
        stream = file.get_input_stream
        stream.readline
        stream.each do |line|
          row = CSV.parse_line(line.force_encoding('UTF-8'))
          Stop.create(_id:       row[0],
                      id:        row[0],
                      # stop_code: row[1],
                      stop_name: row[2],
                      stop_desc: row[3],
                      stop_lat:  row[4],
                      stop_lon:  row[5],
                      # stop_zone_id:        row[6],
                      # stop_url:            row[7],
                      # location_type:       row[8],
                      wheelchair_boarding: row[9])
        end
        stream.close
      when 'stop_times.txt'
        stream = file.get_input_stream
        stream.readline
        stream.each do |line|
          row = CSV.parse_line(line.force_encoding('UTF-8'))
          StopTime.create(trip_id:        row[0],
                          arrival_time:   row[1],
                          departure_time: row[2],
                          stop_id:        row[3],
                          stop_sequence:  row[4],
                          # pickup_type:    row[5],
                          # drop_off_type:  row[6],
                          timepoint:      row[7])
        end
        stream.close
      when 'trips.txt'
        stream = file.get_input_stream
        stream.readline
        stream.each do |line|
          row = CSV.parse_line(line.force_encoding('UTF-8'))
          Trip.create(_id:                   row[2],
                      route_id:              row[0],
                      service_id:            row[1],
                      trip_headsign:         row[3],
                      direction_id:          row[4],
                      block_id:              row[5],
                      shape_id:              row[6],
                      wheelchair_accessible: row[7])
        end
        stream.close
      end
    end
  end
end
