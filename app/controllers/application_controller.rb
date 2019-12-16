class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :token])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  def after_sign_in_path_for(resource)
    admin_path
  end

  def after_sign_out_path_for(resource)
    login_path
  end
end

# TODO Add extra features to trix editor (font size, custom fonts)
# TODO Add date do events' announcements
# TODO Complete dashboard
# TODO Complete help section
# TODO Repair user settings
# TODO Main tabs should have banner image
# TODO Sorting events (panel admin and site)
# TODO Remove multiple blobs for one image
# TODO Admin rights & owner role
# TODO Add tooltips
