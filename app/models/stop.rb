class Stop
  include Mongoid::Document
  field :stop_id, type: Integer
  # field :stop_code, type: Integer
  field :stop_name, type: String
  field :stop_desc, type: String
  field :stop_lat, type: Float
  field :stop_lon, type: Float
  # field :zone_id, type: Integer
  # field :stop_url, type: String
  field :location_type, type: Integer
  field :wheelchair_boarding, type: Integer

  index({ stop_id: 1 }, { unique: true})
end
