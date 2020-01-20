class StopTime
  include Mongoid::Document
  field :trip_id, type: String
  field :arrival_time, type: String
  field :departure_time, type: String
  field :stop_id, type: Integer
  field :stop_sequence, type: Integer
  # field :pickup_type, type: Integer
  # field :drop_off_type, type: Integer
  field :timepoint, type: Boolean

  index({ trip_id: 1, stop_id: 1})
end
