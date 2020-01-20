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
        CSV.parse(file.get_input_stream.read.force_encoding('UTF-8'), :headers => true, :encoding => 'UTF-8').each do |row|
          Calendar.create(_id:        row['service_id'],
                          monday:     row['monday'],
                          tuesday:    row['tuesday'],
                          wednesday:  row['wednesday'],
                          thursday:   row['thursday'],
                          friday:     row['friday'],
                          saturday:   row['saturday'],
                          sunday:     row['sunday'],
                          start_date: row['start_date'],
                          end_date:   row['end_date'])
        end
      when 'calendar_dates.txt'
        CSV.parse(file.get_input_stream.read.force_encoding('UTF-8'), :headers => true, :encoding => 'UTF-8').each do |row|
          CalendarDate.create(service_id:     row['service_id'],
                              date:           row['date'],
                              exception_type: row['exception_type'])
        end
      when 'routes.txt'
        CSV.parse(file.get_input_stream.read.force_encoding('UTF-8'), :headers => true, :encoding => 'UTF-8').each do |row|
          Route.create(_id:              row['route_id'],
                       agency_id:        row['agency_id'],
                       route_short_name: row['route_short_name'],
                       route_long_name:  row['route_long_name'],
                       route_desc:       row['route_desc'],
                       route_type:       row['route_type'],
                       route_color:      row['route_color'],
                       route_text_color: row['route_text_color'])
        end
      when 'shapes.txt'
        CSV.parse(file.get_input_stream.read.force_encoding('UTF-8'), :headers => true, :encoding => 'UTF-8').each do |row|
          Shape.create(shape_id:          row['shape_id'],
                       shape_pt_lat:      row['shape_pt_lat'],
                       shape_pt_lon:      row['shape_pt_lon'],
                       shape_pt_sequence: row['shape_pt_sequence'])
        end
      when 'stops.txt'
        CSV.parse(file.get_input_stream.read.force_encoding('UTF-8'), :headers => true, :encoding => 'UTF-8').each do |row|
          Stop.create(_id:       row['stop_id'],
                      # stop_code: row['stop_code'],
                      stop_name: row['stop_name'],
                      stop_desc: row['stop_desc'],
                      stop_lat:  row['stop_lat'],
                      stop_lon:  row['stop_lon'],
                      wheelchair_boarding: row['wheelchair_boarding'])
        end
        when 'trips.txt'
          CSV.parse(file.get_input_stream.read.force_encoding('UTF-8'), :headers => true, :encoding => 'UTF-8').each do |row|
            Trip.create(_id:                   row['trip_id'],
                        route_id:              row['route_id'],
                        service_id:            row['service_id'],
                        trip_headsign:         row['trip_headsign'],
                        direction_id:          row['direction_id'],
                        block_id:              row['block_id'],
                        shape_id:              row['shape_id'],
                        wheelchair_accessible: row['wheelchair_accessible'])
          end
      end
    end
  end
end
