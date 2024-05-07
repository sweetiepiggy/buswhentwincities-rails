require 'csv'
require 'open-uri'

class Shape
  include Mongoid::Document
  field :shape_id, type: Integer
  field :shape_pt_lat, type: Float
  field :shape_pt_lon, type: Float
  field :shape_pt_sequence, type: Integer

  index({ shape_id: 1})

  def self.import(uri)
    URI.open(uri).each do |line|
      row = CSV.parse_line(line.force_encoding('UTF-8'))
      Shape.create(shape_id:          row[0],
                   shape_pt_lat:      row[1],
                   shape_pt_lon:      row[2],
                   shape_pt_sequence: row[3])
    end
  end
end
