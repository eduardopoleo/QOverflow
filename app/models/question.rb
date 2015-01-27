class Question < ActiveRecord::Base
  include Voteable

  belongs_to :user
  belongs_to :category
  has_many :answers , -> { order 'created_at desc' }
  validates_presence_of :title

  def most_relevant_answer
    max_score = 0
    most_relevant = nil

    answers.each do |answer|
      if answer.total_votes > max_score
        most_relevant = answer
      end
    end

    most_relevant
  end
end
