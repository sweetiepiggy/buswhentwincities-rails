require 'csv'
require 'open-uri'

class Trip
  include Mongoid::Document
  field :route_id, type: String
  field :service_id, type: String
  field :trip_headsign, type: String
  field :direction_id, type: Integer
  field :block_id, type: Integer
  field :shape_id, type: Integer
  # field :wheelchair_accessible, type: Integer

  index({ block_id: 1})

  def self.import(uri)
    URI.open(uri).each do |line|
      row = CSV.parse_line(line.force_encoding('UTF-8'))
      Trip.create(_id:                   row[2],
                  route_id:              row[0],
                  service_id:            row[1],
                  trip_headsign:         row[3],
                  direction_id:          row[4],
                  #direction:             row[5],
                  block_id:              row[6],
                  shape_id:              row[7]
                  # wheelchair_accessible: row[8]
                  #branch_letter:         row[9]
                 )
    end
  end
end
