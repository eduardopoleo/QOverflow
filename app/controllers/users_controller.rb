class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = 'Your account was succesfully created'
      session[:user_id] = @user.id
      redirect_to questions_path
    else
      render 'sessions/signin'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end
