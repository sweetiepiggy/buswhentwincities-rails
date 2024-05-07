require 'csv'
require 'open-uri'

class Route
  include Mongoid::Document
  field :agency_id, type: Integer
  field :route_short_name, type: String
  field :route_long_name, type: String
  field :route_desc, type: String
  field :route_type, type: Integer
  # field :route_url, type: String
  field :route_color, type: String
  field :route_text_color, type: String

  def self.import(uri)
    URI.open(uri).each do |line|
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
  end
end
