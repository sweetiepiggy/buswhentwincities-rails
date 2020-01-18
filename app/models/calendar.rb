class Calendar
  include Mongoid::Document
  field :monday, type: Boolean
  field :tuesday, type: Boolean
  field :wednesday, type: Boolean
  field :thursday, type: Boolean
  field :friday, type: Boolean
  field :saturday, type: Boolean
  field :sunday, type: Boolean
  field :start_date, type: Date
  field :end_date, type: Date
end
