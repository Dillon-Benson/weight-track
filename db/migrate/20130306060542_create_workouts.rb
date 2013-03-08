class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name
      t.integer :weight
      t.integer :sets
      t.integer :reps
      t.string :last_plateau_date
      t.integer :user_id

      t.timestamps
    end
  end
end
