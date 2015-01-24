class SessionsController < ApplicationController
  def signin
    @user = User.new
    render :signin
  end

  def login 
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have succesfully loged in '
      redirect_to questions_path
    else
      flash[:notice] = 'There is a problem on your username or password'
      redirect_to signin_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'You have successfully logged out'
    redirect_to signin_path
  end
end
