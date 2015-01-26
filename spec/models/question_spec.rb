require 'spec_helper'

describe Question do
  let(:question) { Fabricate(:question) }
  before{30.times{Fabricate(:user)}}

  describe '#positive_votes' do
    it 'adds up all the positive votes the questions have' do
      User.all.each do |user|
        Fabricate(:vote, vote: true, voteable: question, user: user)
      end
      expect(question.positive_votes).to eq(30)
    end
  end

  describe '#negative_votes' do
    it 'adds up all the  votes the questions have' do
      User.all.each do |user|
        Fabricate(:vote, vote: false, voteable: question, user: user)
      end
      expect(question.negative_votes).to eq(30)
    end
  end
  
  describe '#total_votes' do
    it 'adds up all the votes (negatives and positives)' do
      vote = true
      count = 0

      User.all.each do |user|
        vote = false if count >= 23 
        Fabricate(:vote, vote: vote, voteable: question, user: user)
        count += 1
      end
      expect(question.total_votes).to eq(16)
    end
  end

  describe '#most_relevan_answer' do
    it 'returns the answer with the highest value of number of votes' do
      answer1 = Fabricate(:answer, question: question)
      answer2 = Fabricate(:answer, question: question)
      3.times{Fabricate(:vote, voteable:answer1, vote: true)}
      Fabricate(:vote, voteable:answer2, vote: true)
      expect(question.most_relevant_answer).to eq(answer1)
    end
  end
end 
