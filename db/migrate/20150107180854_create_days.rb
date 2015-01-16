class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :date
      t.string :datetime
      t.string :time_to_plane
      t.string :actual_time

      t.timestamps
    end
  end
end
