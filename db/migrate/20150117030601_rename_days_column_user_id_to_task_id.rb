class RenameDaysColumnUserIdToTaskId < ActiveRecord::Migration
  def up
    rename_column :days, :user_id, :task_id
  end

  def down
    rename_column :days, :task_id, :user_id
  end
end
