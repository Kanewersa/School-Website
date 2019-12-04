class UsersController < ApplicationController
  before_action :check_privileges

  def delete
    user = User.find(params[:user_id])
    user.status = "inactive"
    user.save
    redirect_to users_path
  end

  def suspend
    user = User.find(params[:user_id])
    user.status = "suspended"
    user.save
    redirect_to users_path
  end

  def activate
    user = User.find(params[:user_id])
    user.status = "active"
    user.save
    redirect_to users_path
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
