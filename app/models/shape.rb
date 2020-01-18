class Shape
  include Mongoid::Document
  field :shape_id, type: Integer
  field :shape_pt_lat, type: Float
  field :shape_pt_lon, type: Float
  field :shape_pt_sequence, type: Integer

  index({ shape_id: 1})
end
