class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :date
      t.string :datetime
      t.datetime :time_to_plane
      t.datetime :actual_time

      t.timestamps
    end
  end
end
