require 'csv'
require 'open-uri'

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

  def self.import(uri)
    URI.open(uri).each do |line|
      row = CSV.parse_line(line.force_encoding('UTF-8'))
      Calendar.create(_id:        row[0],
                      monday:     row[1],
                      tuesday:    row[2],
                      wednesday:  row[3],
                      thursday:   row[4],
                      friday:     row[5],
                      saturday:   row[6],
                      sunday:     row[7],
                      # dates will be stored in table as utc but are really in local time
                      start_date: row[8],
                      end_date:   row[9])
    end
  end
end
