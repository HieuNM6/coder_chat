class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email:params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
        flash[:success] = "Login successful"
        session[:user_id] = @user.id
        redirect_to root_path
    else
        flash.now[:error] = "Login unsuccessful"
        render 'new'
    end
  end

  def destroy
    flash[:success] = "Logout successful"
    session[:user_id] = nil
    redirect_to root_path, status: 303  
  end

  def callback
    if user = User.from_omniauth(env["omniauth.auth"])
      # log in user here
      flash[:success] = "Sign in with facebook successful"
      session[:user_id] = user.id
      redirect_to root_path
    else
      # don't log user in
      flash[:error] = "Fail to sign in with facebook"
      redirect_to root_path
    end
  end 
end
