class UsersController < ApplicationController
  before_action :check_privileges

  def delete
    user = User.find(params[:user_id])
    user.update_attribute('status', 'inactive')
    redirect_to users_path
  end

  def suspend
    user = User.find(params[:user_id])
    user.update_attribute('status', 'suspended')
    redirect_to users_path
  end

  def activate
    user = User.find(params[:user_id])
    user.update_attribute('status', 'active')
    redirect_to users_path
  end

  def update
    abort current_user.inspect
  end

  private
  def check_privileges
   unless user_signed_in? && current_user.has_role?(:admin) && current_user.status == "active"
     redirect_to login_path
   end
  end

  def edit

  end
end
