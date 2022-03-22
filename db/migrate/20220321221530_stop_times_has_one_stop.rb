class AddStopToStopTime < ActiveRecord::Migration
  def change
    add_reference :stop_times, :stop
  end
end
