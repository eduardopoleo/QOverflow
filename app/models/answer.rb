class Answer < ActiveRecord::Base
  include Voteable

  belongs_to :question
  belongs_to :user
  validates_presence_of :description
  validates :description, length: {minimum: 10}
end
