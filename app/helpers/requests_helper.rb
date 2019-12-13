module RequestsHelper

  def action_name(name)
    case name
    when "create"
      "Stwórz"
    when "destroy"
      "Usuń"
    else
      "Edytuj"
    end
  end

  def resource_type(type)
    case type
    when "Event"
      "wydarzenie"
    else
      "zakładkę"
    end
  end

  def resource_name(name)

  end

end
