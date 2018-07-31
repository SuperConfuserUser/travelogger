module FormsHelper
  #ERROR ALERT
  def error_alert(errors, obscured = false)
    render 'forms/error_alert', errors: errors, obscured: obscured if errors.present?
  end
 

  def error_alert_title(errors, obscured)
    if !obscured
     content_tag :h3, "There #{errors.count < 2 ? 'was ' : 'were '} #{pluralize(errors.count, "error")}!", class: "errors"
    end
  end

  def error_base_message(errors)
    if errors[:base].present?
      content_tag :p, errors[:base].join(", "), class: "errors"
    end
  end

  def error_message(name, error)
    render 'forms/error_message', error_message: "#{name} #{error.first}." if error.present?
  end

  def add_error_div(error)
    if error
      render 'forms/error_div' do
        yield
      end
    else
      yield
    end
  end

  #OTHER
  def form_submit_text(param)
    param.new_record? ? "Submit" : "Update"
  end
  
end