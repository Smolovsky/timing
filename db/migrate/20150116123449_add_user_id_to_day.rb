class AddUserIdToDay < ActiveRecord::Migration
  def up
    add_column :days, :user_id, :integer
  end

  def down
    remove_column :days, :user_id
  end
end
