require 'spec_helper'

describe QuestionsController do
  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'sets a new @question instance variable' do
      get :new
      expect(assigns(:question)).to be_new_record
      expect(assigns(:question)).to be_instance_of(Question)
    end
  end
  
  describe 'POST create' do
    context 'with authenticated user' do
      let(:alice){Fabricate(:user)}
      let(:drama){Fabricate(:category)}

      before{session[:user_id]= alice.id}

      it 'redirects to the show question page' do
        post :create, question: {title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', user: alice, category: drama } 
        expect(response).to redirect_to questions_path
      end

      it 'creates a question' do
        post :create, question: {title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', user: alice, category: drama } 
        expect(Question.count).to eq(1)
      end

      it 'creates a question associated with a sign in user' do
        post :create, question: {  title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', category: drama } 
        expect(Question.first.user).to eq(alice)
      end

      it 'creates a question associated with category' do
        post :create, question: {  title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', category_id: drama.id } 
        expect(Question.first.category).to eq(drama)
      end

      it 'sets flash notice if the question has been created'
      it 'does not create a question if there is not question title'
      it 'renders the new question page if the question can not be created'
    end

    it 'redirects to the sign in path if the user is not authenticated'
  end
end
