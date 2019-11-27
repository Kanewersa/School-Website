module ApplicationHelper

  def has_role?(role)
    current_user && current_user.has_role?(role)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
