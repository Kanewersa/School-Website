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

  def ajax_redirect_to(path)
    respond_to do |format|
      format.js { render js: "window.location='#{path}'" }
    end
  end
end

# TODO Add extra features to trix editor (font size, custom fonts)
# TODO Complete dashboard
# TODO Complete help section
# TODO Repair user settings
# TODO Add requests display in users tab
# TODO Add tooltips
# TODO Add image validation on some requestables
