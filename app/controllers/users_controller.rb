class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email.downcase!

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Account created successfully!"

      UserMailer.welcome_email(@user).deliver_later
      redirect_to root_path
    else
      flash[:notice] = "Account could not be created!"
      puts @user.errors.messages
      redirect_to register_path
    end
  end

  def destroy
    redirect_to root_path
  end

  def show
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
