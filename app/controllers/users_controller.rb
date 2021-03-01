class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  # private

  # def user_params
  #   params.require(:user).permit(:name, :email)
  # end

  # def set_user
  #   @user = User.find(params[:id])
  # end

end
