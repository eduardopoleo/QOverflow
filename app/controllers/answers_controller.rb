class AnswersController < ApplicationController
  before_action :require_user
  before_action :set_question

  def create
    @answer = set_new_answer 

    if user_double_answers? 
      redirect_to question_path(@question)
      flash[:notice] = "You can not answer a question twice"
    elsif @answer.save 
      redirect_to question_path(params[:question_id])
    else
      render 'questions/show'
    end
  end 

  def vote
    @answer = Answer.find(params[:id])
    @vote = Vote.create(user: current_user, vote: params[:vote], voteable: @answer)
    redirect_to question_path(@question)
  end

  private
  def answer_params
    params.require(:answer).permit(:description)
  end

  def set_question
   @question =  Question.find(params[:question_id])
  end

  def set_new_answer
    @question.answers.build(answer_params.merge!(user: current_user))
  end

  def user_double_answers?
    Answer.where("user_id = ? and question_id = ?", "#{current_user.id}", "#{set_question.id}").present?
  end
end
