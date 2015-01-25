require 'spec_helper'

describe SessionsController do
  describe 'GET signin' do
    it 'renders the signin form' do
      get :signin
      expect(response).to render_template :signin
    end

    it 'sets a new instance of todo' do
      get :signin
      expect(assigns(:user)).to be_new_record
    end

    it 'redirects to the questions path if there is already a user id in the session' do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      get :signin
      expect(response).to redirect_to questions_path
    end
  end   

  describe 'POST login' do
    context 'With valid inputs' do
      let(:alice) {Fabricate(:user)}
      before {post :login, username: alice.username, password: alice.password}

      it 'redirects to the questions index page' do
        expect(response).to redirect_to questions_path
      end

      it 'sets the user_id in the session' do
        expect(session[:user_id]).to eq(alice.id)
      end

      it 'sets a flash message' do
        expect(flash[:notice]).to be_present
      end
    end

    context 'With invalid inputs' do
      it 'does not set the user_id in the session if the password is incorrect' do
        alice = Fabricate(:user, password: 'hellodejaelsho')
        post :login, username: alice.username, password: 'hisoyjode'
        expect(session[:user_id]).to be_nil
      end

      it 'does not set the user_id in the session if the username is incorrect' do
        alice = Fabricate(:user, username: 'eduardo')
        post :login, username: 'edwardo', password: alice.password 
        expect(session[:user_id]).to be_nil
      end

      it 'sets a flash notice' do
        alice = Fabricate(:user, username: 'eduardo')
        post :login, username: 'edwardo', password: alice.password 
        expect(flash[:notice]).to be_present
      end

      it 'redirects to the signin path' do
        alice = Fabricate(:user, password: 'hellodejaelsho')
        post :login, username: alice.username, password: 'hisoyjode'
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe 'GET logout' do
    let (:alice) {Fabricate(:user)}
    before{session[:user_id] = alice}

    it 'sets the session[:user_id] to nil' do
      get :logout
      expect(session[:user_id]).to eq(nil)
    end

    it 'redirects to the signin path' do
      get :logout
      expect(response).to redirect_to signin_path
    end
     
    it 'sets a flash notice' do
      get :logout
      expect(flash[:notice]).to be_present
    end
  end
end
