class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @name = current_user.name
    @posts = @user.posts.order("updated_at DESC")
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
