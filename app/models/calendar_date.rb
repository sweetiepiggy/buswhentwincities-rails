class CalendarDate
  include Mongoid::Document
  field :service_id, type: Integer
  field :date, type: Date
  field :exception_type, type: Integer

  index({ date: 1})
end
