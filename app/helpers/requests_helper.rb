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

  def resource_type_name(type)
    case type
    when "Event"
      "wydarzenie"
    else
      "zakładkę"
    end
  end

  def status_name(status)
    case status
    when "canceled"
      "<i class='fas fa-pause' data-toggle='tooltip' title='Anulowałeś swoje zgłoszenie'> Anulowano</i>".html_safe
    when "pending"
      "<i class='fas fa-hourglass-half' data-toggle='tooltip' title='Zgłoszenie oczekuje na rozpatrzenie przez administratora'> W trakcie</i>".html_safe
    when "approved"
      "<i class='fas fa-check' data-toggle='tooltip' title='Zgłoszenie zostało rozpatrzone pozytywnie'> Zaakceptowano</i>".html_safe
    else
      "<i class='fas fa-times' data-toggle='tooltip' title='Zgłoszenie zostało odrzucone'> Odrzucono</i>".html_safe
    end
  end

end
