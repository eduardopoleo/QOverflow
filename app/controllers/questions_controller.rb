class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.create(question_params.merge!(user_id: current_user.id))

    if params[:question][:category_id] 
      @question.category = Category.find(params[:question][:category_id])
      @question.save
    end

    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :description)
  end
  
end
