class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :time_to_plan
      t.integer :user_id

      t.timestamps

    end
  end
end
