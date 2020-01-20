class Trip
  include Mongoid::Document
  field :route_id, type: Integer
  field :service_id, type: Integer
  field :trip_headsign, type: String
  field :direction_id, type: Integer
  field :block_id, type: Integer
  field :shape_id, type: Integer
  # field :wheelchair_accessible, type: Integer

  index({ block_id: 1})
end
