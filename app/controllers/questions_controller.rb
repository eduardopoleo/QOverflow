class QuestionsController < ApplicationController
  # before_action :require_user
  def index
    @questions = Question.all  
  end

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.create(question_params.merge!(user_id: current_user.id))
    if @question.save
      if params[:question][:category_id] 
        @question.category = Category.find(params[:question][:category_id])
        @question.save
      end
      flash[:notice] = 'Your question has been succesfully posted!'
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :description)
  end
  
end
