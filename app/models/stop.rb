require 'csv'
require 'open-uri'

class Stop
  include Mongoid::Document
  field :id, type: Integer # for backwards compatibility
  # field :stop_code, type: Integer
  field :stop_name, type: String
  # field :stop_desc, type: String
  field :stop_lat, type: Float
  field :stop_lon, type: Float
  # field :zone_id, type: Integer
  # field :stop_url, type: String
  # field :location_type, type: Integer
  # field :wheelchair_boarding, type: Integer

  def self.import(uri)
    URI.open(uri).each do |line|
      row = CSV.parse_line(line.force_encoding('UTF-8'))
      Stop.create(_id:       row[0],
                  id:        row[0],
                  # stop_code: row[1],
                  stop_name: row[2],
                  # stop_desc: row[3],
                  stop_lat:  row[4],
                  stop_lon:  row[5]
                  # stop_url:            row[6],
                  # location_type:       row[7],
                  # wheelchair_boarding: row[8]
                  # platform_code        row[9],
                 )
    end
  end
end
