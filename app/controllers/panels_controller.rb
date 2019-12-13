class PanelsController < ApplicationController
  before_action :check_if_user_logged
  respond_to :html, :js
  layout 'dashboard'

  def check_if_user_logged
    unless user_signed_in?
      redirect_to login_path
    end
  end

  helper_method :find_request_object
  def find_request_object(request)
    id = request[:requestable_id]
    if request[:action].start_with?("edit")
      text = request[:action].split("/")
      id = text[1]
    end
    request[:requestable_type].classify.constantize.find(id)
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

  def tokens
    check_if_admin
  end

  def events
    @events = Event.all.where(:status => 1).order("important DESC, created_at DESC")
  end

  def sub_tabs
    @main_tabs = MainTab.all
    # TODO Delete warning get's called twice (duplicated JQUERY)
  end

  def requests
    @requests = Request.all.where("status > 0").order("FIELD(status, '1', '3', '2')")
  end

  def generate_token
    check_if_admin

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
