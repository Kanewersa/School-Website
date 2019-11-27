
class UsersController < ApplicationController
  before_action :check_privileges

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
  def check_privileges
   unless user_signed_in? && current_user.has_role?(:admin)
     redirect_to login_path
   end
  end
end
