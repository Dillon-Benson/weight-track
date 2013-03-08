class Workout < ActiveRecord::Base
  belongs_to :user
  attr_accessible :last_plateau_date, :name, :reps, :sets, :user_id, :weight
end
