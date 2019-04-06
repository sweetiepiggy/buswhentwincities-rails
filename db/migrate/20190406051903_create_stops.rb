class CreateStops < ActiveRecord::Migration[5.2]
  def change
    create_table :stops do |t|
      t.string :stop_code
      t.string :stop_name, :null => false
      t.string :stop_desc
      t.float :stop_lat, :null => false
      t.float :stop_lon, :null => false
      t.integer :wheelchair_boarding

      t.timestamps
    end
  end
end
