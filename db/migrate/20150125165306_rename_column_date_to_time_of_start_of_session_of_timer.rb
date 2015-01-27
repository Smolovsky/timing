class RenameColumnDateToTimeOfStartOfSessionOfTimer < ActiveRecord::Migration
  def up
    rename_column :session_of_timers, :date, :start_time
  end

  def down
    rename_column :session_of_timers, :session_of_timers, :date
  end

end
