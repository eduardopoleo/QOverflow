module Voteable
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, as: :voteable
  end

  def positive_votes
    votes.where(vote: true).count
  end

  def negative_votes
    votes.where(vote: false).count
  end

  def total_votes
    positive_votes - negative_votes
  end
end
