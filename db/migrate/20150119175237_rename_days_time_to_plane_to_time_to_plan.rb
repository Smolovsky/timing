class RenameDaysTimeToPlaneToTimeToPlan < ActiveRecord::Migration
  def up
    rename_column :days, :time_to_plane, :time_to_plan
  end

  def down
    rename_column :days, :time_to_plan, :time_to_plane
  end
end
