class PanelsController < ApplicationController
  before_action :check_if_user_logged
  respond_to :html, :js
  layout 'dashboard'

  def change_background_color
    current_user.background_color = params[:color]
    current_user.save
  end

  def change_background_image
    current_user.background_image = params[:image]
    current_user.save
  end

  def users
    check_if_user_is_admin
  end

  def tokens
    check_if_user_is_admin
  end

  def events
    @events = Event.all.where(:status => 1).order("important DESC, created_at DESC")
  end

  def sub_tabs
    @main_tabs = MainTab.all
    # TODO Delete warning get's called twice (duplicated JQUERY)
  end

  def requests
    puts "PUTS!!!"
    puts current_user.id
    case params[:command]
    when "all"
      adm = "status > 0"
      usr = "user_id = ? AND status > ?", current_user.id, 0
    when "new"
      adm = "status = 1"
      usr = "user_id = ? AND status = ?", current_user.id, 1
    when "approved"
      adm = "status = 2"
      usr = "user_id = ? AND status = ?", current_user.id, 2
    when"rejected"
      adm = "status = 3"
      usr = "user_id = ? AND status = ?", current_user.id, 3
    else
      adm = "status = 4"
      usr = "user_id = ? AND status = ?", current_user.id, 4
    end

    if current_user.has_role?(:admin)
      @requests = Request.all.where(adm).order("FIELD(status, '1', '3', '2')")
    else
      @requests = Request.all.where(usr).order("FIELD(status, '1', '3', '2')")
    end
  end

  def generate_token
    check_if_user_is_admin

    @token = Token.new
    code = SecureRandom.hex(4)
    value = {value: code}
    @token.role = params[:role]
    @token.value = code
    @token.name = params[:name]
    @token.created_by = current_user.username
    @token.save
    render json: value
  end
end
