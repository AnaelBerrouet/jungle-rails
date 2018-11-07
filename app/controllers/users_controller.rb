class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email.downcase!

    if @user.save
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      flash[:notice] = "Account coulr not be created! - " + @user.save.errors.messages
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
      :name,
      :last_name,
      :email,
      :password,
    )
  end

end
