module ApplicationHelper
  # Return full title on a per-page basis.
  def full_title page_title = ""
    base_title = I18n.t("dictionary.base_title")
    page_title.empty? ? base_title : (page_title + " | " + base_title)
  end

  def message_types message_type
    return "success" if message_type == "notice"
    return "danger" if message_type == "alert"
    message_type
  end
end
