require 'csv'
require 'open-uri'

class StopTime
  include Mongoid::Document
  field :trip_id, type: String
  field :arrival_time, type: DateTime
  field :departure_time, type: DateTime
  field :stop_id, type: Integer
  field :stop_sequence, type: Integer
  # field :pickup_type, type: Integer
  # field :drop_off_type, type: Integer
  field :timepoint, type: Boolean

  index({ trip_id: 1, stop_id: 1})

  def self.import(uri)
    URI.open(uri).each do |line|
      row = CSV.parse_line(line.force_encoding('UTF-8'))
      StopTime.create(trip_id:        row[0],
                      arrival_time:   "2022-01-01T#{row[1]}#{timezone_offset}",
                      departure_time: "2022-01-01T#{row[2]}#{timezone_offset}",
                      stop_id:        row[3],
                      stop_sequence:  row[4],
                      # pickup_type:    row[5],
                      # drop_off_type:  row[6],
                      timepoint:      row[7])
    end
  end
end
