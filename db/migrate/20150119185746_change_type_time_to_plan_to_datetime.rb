class ChangeTypeTimeToPlanToDatetime < ActiveRecord::Migration
  def up
    remove_column :days, :time_to_plan, :string
    add_column    :days, :time_to_plan, :datetime

    remove_column :tasks, :time_to_plan, :string
    add_column    :tasks, :time_to_plan, :datetime
  end

  def down
    remove_column :days, :time_to_plan, :datetime
    add_column    :days, :time_to_plan, :string

    remove_column :tasks, :time_to_plan, :datetime
    add_column    :tasks, :time_to_plan, :string
  end
end
