# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'stops.txt'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  Stop.create(id: row['stop_id'],
              stop_code: row['stop_code'],
              stop_name: row['stop_name'],
              stop_desc: row['stop_desc'],
              stop_lat:  row['stop_lat'],
              stop_lon:  row['stop_lon'],
              wheelchair_boarding: row['wheelchair_boarding'])
end

