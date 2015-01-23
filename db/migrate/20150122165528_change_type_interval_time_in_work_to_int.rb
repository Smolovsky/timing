class ChangeTypeIntervalTimeInWorkToInt < ActiveRecord::Migration
  def up
    remove_column :session_of_timers, :time_in_work
    add_column :session_of_timers, :time_in_work, :integer
  end

  def down
    remove_column :session_of_timers, :time_in_work, :integer
    add_column :session_of_timers, :time_in_work, :datetime
  end
end
