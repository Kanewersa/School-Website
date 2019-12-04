class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    token = Token.where(value: params[:user][:token])
    if token.present?
      super do |user|
        info = token.select(:role, :name).take!
        user.fullname = info[:name]
        user.add_role info[:role]
        user.activate
        token = token.take!
        token.destroy
      end
    else
      redirect_to register_path and false;
    end
  end

  def update
    super
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :token)
  end
end
