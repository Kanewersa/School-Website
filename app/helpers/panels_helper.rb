module PanelsHelper

  def role_name(user)
    case user.roles.first.name
    when 'admin'
      "Administrator"
    when 'user'
      "Użytkownik"
    else
      "Nieznana rola"
    end
  end

  def token_role(token)
    case token.role
    when 'admin'
      "Administrator"
    when 'user'
      "Użytkownik"
    else
      "Nieznana rola"
    end
  end

  def user_status_name(user)
    case user.status
    when "active"
      "<i class='fas fa-check'></i> Aktywny".html_safe
    when "suspended"
      "<i class='fas fa-user-minus'></i> Zawieszony".html_safe
    else
      "<i class='fas fa-times-circle'></i> Nieaktywny".html_safe
    end
  end

end
