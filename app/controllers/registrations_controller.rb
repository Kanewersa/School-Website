class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    token = Token.where(value: params[:user][:token])

    unless token.present?
      redirect_to register_path and return false;
    else
      params[:user].add_role(token.role)
    end
    super

  end

  def update
    super
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :token)
  end
end
