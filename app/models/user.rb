class User < ActiveRecord::Base  
  has_many :workouts
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100" }
  attr_accessible :email, :password, :username, :avatar
  validates :email, :email => true
  validates :email, :username, :password, :presence => true
  validates :username, :length => { :in => 6..18 }
  validates :username, :email, :uniqueness => true
end
