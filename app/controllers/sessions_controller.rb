class SessionsController < ApplicationController

  def new
  end

  def create
    # @user = User.find_by_email(params[:login][:email])
    # if @user && @user.authenticate(params[:login][:password])

    if @user = User.authenticate_with_credentials(params[:login][:email], params[:login][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:notice] = "Login failed!"
      redirect_to '/login'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end
end
