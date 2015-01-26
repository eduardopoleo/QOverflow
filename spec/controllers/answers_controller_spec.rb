require 'spec_helper'

describe AnswersController do
  let (:user) {Fabricate(:user)} 
  before{session[:user_id] =  user.id}

  describe 'POST create' do
    let(:question) { Fabricate(:question) }

    context 'with valid inputs' do
      before{post :create, answer:{description: 'Short descriptions'}, question_id: question.id}

      it 'redirects to the question show page' do
        expect(response).to redirect_to question_path(question)
      end

      it 'creates the answer' do
        expect(Answer.count).to eq(1)
      end

      it 'creates an answer related to the parent question' do
        expect(Answer.first.question).to eq(question)
      end

      it 'creates an answer related to the parent user' do
        expect(Answer.first.user).to eq(user)
      end
    end

    it 'does not create answer if there is no description' do
      post :create, answer:{description:''}, question_id: question.id
      expect(Answer.count).to eq(0)
    end

    it 'does not create answer with descriptions shorter than 10 characters' do
      post :create, answer:{description:'hola'}, question_id: question.id
      expect(Answer.count).to eq(0)
    end

    it 'does not create two answers for the same question and user' do
      answer = Fabricate(:answer, user: user, question: question)
      post :create, answer:{description:'hola this is efs fasf fa'}, question_id: question.id
      expect(Answer.count).to eq(1)
    end

    it 'set a flash notice if the users try to answer the question twice' do
      answer = Fabricate(:answer, user: user, question: question)
      post :create, answer:{description:'hola this is efs fasf fa'}, question_id: question.id
      expect(flash[:notice]).to be_present
    end

    it 'renders the show question page if the question fails validation' do
      post :create, answer:{description:'hola'}, question_id: question.id
      expect(response).to render_template "questions/show"
    end

    it 'sets the @question instance variable if the answer fails to be created' do
      post :create, answer:{description:'hola'}, question_id: question.id
      expect(assigns(:question)).to eq(question)
    end

    it 'redirects to the sign in path if the user is not authenticated' do
      session[:user_id] = nil
      post :create, answer:{description:'hola'}, question_id: question.id
      expect(response).to redirect_to signin_path
    end
  end

  describe 'POST vote' do
    let(:question) {Fabricate(:question)}
    let(:answer) {Fabricate(:answer)}

    context 'with valid credentials' do
      before {post :vote, vote: true, id: answer.id, question_id: question.id}

      it 'redirects back to the response to where it came' do
        # the url questions/:question_id/answers/:answer_id/vote
        # There is no way to test redirect back to the controller 
        expect(response).to redirect_to question_path(question)
      end

      it 'creates a vote' do
        expect(Vote.count).to eq(1)
      end

      it 'creates a vote associated with the user' do
        expect(Vote.first.user).to eq(user)
      end
      
      it 'creates a vote associated with a specific question' do
        expect(Vote.first.voteable).to eq(answer)
      end
    end

    it 'redirects back to the signin page if the user is not authenticated' do
      session[:user_id] = nil
      post :vote, vote: true, id: answer.id, question_id: question.id
      expect(response).to redirect_to signin_path
    end

    it 'ensures uniquesness of vote per user per question (a user can not vote twice on an item)' do
      Fabricate(:vote, voteable: answer, vote: true, user: user)
      post :vote, vote: true, id: answer.id, question_id: question.id
      expect(Vote.count).to eq(1)
    end
  end
end
