require 'spec_helper'

describe QuestionsController do
  describe 'GET new' do
    let(:alice){Fabricate(:user)}
    before{session[:user_id]= alice.id}

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'sets a new @question instance variable' do
      get :new
      expect(assigns(:question)).to be_new_record
      expect(assigns(:question)).to be_instance_of(Question)
    end

    # it 'redirects to the signin_path if the user is not authenticated' do
    #   session[:user_id] = nil
    #   get :new
    #   expect(response).to redirect_to signin_path
    # end
  end
  
  describe 'POST create' do
    let(:alice){Fabricate(:user)}
    before{session[:user_id]= alice.id}
    let(:drama){Fabricate(:category)}

    context 'with authenticated user' do
      it 'redirects to the show question page' do
        post :create, question: {title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', user: alice, category: drama } 
        expect(response).to redirect_to question_path(Question.first)
      end

      it 'creates a question' do
        post :create, question: {title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', user: alice, category: drama } 
        expect(Question.count).to eq(1)
      end

      it 'creates a question associated with a sign in user' do
        post :create, question: {  title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', category: drama } 
        expect(Question.first.user).to eq(alice)
      end

      it 'creates a question associated with category if the category is presents'  do
        post :create, question: {  title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', category_id: drama.id } 
        expect(Question.first.category).to eq(drama)
      end

      it 'sets flash notice if the question has been created' do
        post :create, question: {  title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', category_id: drama.id } 
        expect(flash[:notice]).to be_present
      end

      it 'does not create a question if there is not question title' do
        post :create, question: {description:'Random fasfsfskljj sfsfsaf fasf fsaf', category_id: drama.id } 
        expect(Question.count).to eq(0)
      end

      it 'renders the new question page if the question can not be created' do
        post :create, question: {description:'Random fasfsfskljj sfsfsaf fasf fsaf', category_id: drama.id } 
        expect(response).to render_template :new 
      end
    end

    # it 'redirects to the sign in path if the user is not authenticated' do
    #   session[:user_id] = nil
    #   post :create, question: {  title: 'Some random title?', description:'Random fasfsfskljj sfsfsaf fasf fsaf', category_id: drama.id } 
    #   expect(response).to redirect_to signin_path
    # end
  end
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'sets up the @questions instances variables' do
      question1 = Fabricate(:question)
      question2 = Fabricate(:question)
      get :index
      expect(assigns(:questions)).to match_array([question2, question1])
    end
    # it 'redirects to the the signin page if user is not authenticated' 
  end
end
