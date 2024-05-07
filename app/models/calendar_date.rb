require 'csv'
require 'open-uri'

class CalendarDate
  include Mongoid::Document
  field :service_id, type: String
  field :date, type: Date
  field :exception_type, type: Integer

  index({ date: 1})

  def self.import(uri)
    URI.open(uri).each do |line|
      row = CSV.parse_line(line.force_encoding('UTF-8'))
      CalendarDate.create(service_id:     row[0],
                          # dates will be stored in table as utc but are really in local time
                          date:           row[1],
                          exception_type: row[2])
    end
  end
end
