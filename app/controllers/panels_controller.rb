class PanelsController < ApplicationController
  before_action :check_if_user_logged
  respond_to :html, :js
  layout 'dashboard'

  def check_if_user_logged
    unless user_signed_in?
      redirect_to login_path
    end
  end

  def check_if_admin
    unless current_user.has_role?(:admin)
      redirect_to login_path
    end
  end

  def change_background_color
    current_user.background_color = params[:color]
    current_user.save
  end

  def change_background_image
    current_user.background_image = params[:image]
    current_user.save
  end

  def users
    check_if_admin
  end

  def sub_tabs
    @main_tabs = MainTab.all
  end

  def generate_token
    @token = Token.new
    code = SecureRandom.hex(4)
    value = {value: code}
    @token.role = "admin"
    @token.value = code
    @token.created_by = current_user.username
    @token.save
    render json: value
  end
end
