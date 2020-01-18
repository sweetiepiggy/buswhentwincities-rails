# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

calendar_text = File.read(Rails.root.join('lib', 'seeds', 'calendar.txt'))
CSV.parse(calendar_text, :headers => true, :encoding => 'UTF-8').each do |row|
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

calendar_dates_text = File.read(Rails.root.join('lib', 'seeds', 'calendar_dates.txt'))
CSV.parse(calendar_dates_text, :headers => true, :encoding => 'UTF-8').each do |row|
  CalendarDate.create(service_id:     row['service_id'],
                      date:           row['date'],
                      exception_type: row['exception_type'])
end

routes_text = File.read(Rails.root.join('lib', 'seeds', 'routes.txt'))
CSV.parse(routes_text, :headers => true, :encoding => 'UTF-8').each do |row|
  Route.create(_id:              row['route_id'],
               agency_id:        row['agency_id'],
               route_short_name: row['route_short_name'],
               route_long_name:  row['route_long_name'],
               route_desc:       row['route_desc'],
               route_type:       row['route_type'],
               route_color:      row['route_color'],
               route_text_color: row['route_text_color'])
end

shapes_text = File.read(Rails.root.join('lib', 'seeds', 'shapes.txt'))
CSV.parse(shapes_text, :headers => true, :encoding => 'UTF-8').each do |row|
  Shape.create(shape_id:          row['shape_id'],
               shape_pt_lat:      row['shape_pt_lat'],
               shape_pt_lon:      row['shape_pt_lon'],
               shape_pt_sequence: row['shape_pt_sequence'])
end

trips_text = File.read(Rails.root.join('lib', 'seeds', 'trips.txt'))
CSV.parse(trips_text, :headers => true, :encoding => 'UTF-8').each do |row|
  Trip.create(_id:                   row['trip_id'],
              route_id:              row['route_id'],
              service_id:            row['service_id'],
              trip_headsign:         row['trip_headsign'],
              direction_id:          row['direction_id'],
              block_id:              row['block_id'],
              shape_id:              row['shape_id'],
              wheelchair_accessible: row['wheelchair_accessible'])
end

stops_text = File.read(Rails.root.join('lib', 'seeds', 'stops.txt'))
CSV.parse(stops_text, :headers => true, :encoding => 'UTF-8').each do |row|
  Stop.create(_id:       row['stop_id'],
              # stop_code: row['stop_code'],
              stop_name: row['stop_name'],
              stop_desc: row['stop_desc'],
              stop_lat:  row['stop_lat'],
              stop_lon:  row['stop_lon'],
              wheelchair_boarding: row['wheelchair_boarding'])
end

