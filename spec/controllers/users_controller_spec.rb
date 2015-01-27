require 'spec_helper'
describe UsersController do
  describe 'POST create' do
    it 'redirects to the question index page'do
      post :create, user: {email: Faker::Internet.email, password: Faker::Internet.password, username: Faker::Internet.user_name}  
      expect(response).to redirect_to questions_path
    end

    it 'creates a user' do
      post :create, user: {email: Faker::Internet.email, password: Faker::Internet.password, username: Faker::Internet.user_name}  
      expect(User.count).to eq(1)
    end

    it 'sets a notice if the the user was succesfully created' do
      post :create, user: {email: Faker::Internet.email, password: Faker::Internet.password, username: Faker::Internet.user_name}  
      expect(flash[:notice]).to be_present
    end

    it 'sets the user id in the session when the is created' do
      post :create, user: {email: Faker::Internet.email, password: Faker::Internet.password, username: Faker::Internet.user_name}  
      expect(session[:user_id]).to eq(User.first.id)
    end

    it 'renders the signin template if the user was not created' do
      post :create, user: {password: Faker::Internet.password, username: Faker::Internet.user_name}  
      expect(response).to render_template :signin
    end
  end
end
