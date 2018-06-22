module UsersHelper
  def user_form_edit_options(form, user)
    render 'users/user_form_edit_options', f: form, user: user if user.persisted?
  end

  def user_form_submit_text(user)
    user.new_record? ? "Submit" : "Update"
  end

  def user_form_password_label(user)
    user.new_record? ? "Password" : "New Password"
  end

  def user_form_password_confirm_label(user)
    user.new_record? ? "Password Confirm" : "New Password Confirm"
  end
end
