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
end
