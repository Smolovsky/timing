class CreateSessionOfTimers < ActiveRecord::Migration
  def change
    create_table :session_of_timers do |t|
      t.datetime :date
      t.integer :day_id
      t.datetime :time_in_work

      t.timestamps
    end
  end
end
