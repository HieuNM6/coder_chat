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
    render 'new'  
  end
end
