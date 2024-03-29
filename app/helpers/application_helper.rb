module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :notice
        "alert-info"
      else
        "alert-info"
    end
  end
end
