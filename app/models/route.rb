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
end
