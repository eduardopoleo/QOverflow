class User < ActiveRecord::Base
  has_many :questions
  has_many :anwsers
  has_many :votes 
  has_secure_password validations: false
  validates_presence_of :email, :username, :password
  validates_uniqueness_of :email, :username 
end
