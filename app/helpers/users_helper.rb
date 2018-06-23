module UsersHelper
  def user_form(user)
    render 'user_form', user: user
  end
  
  def user_form_edit_options(form, user)
    render 'users/user_form_edit_options', f: form, user: user if user.persisted?
  end

  def user_form_password_label(user)
    user.new_record? ? "Password" : "New Password"
  end

  def user_form_password_confirm_label(user)
    user.new_record? ? "Password Confirm" : "New Password Confirm"
  end

  def user_trips_count_link(user)
    link_to "(#{pluralize(user.trips.count, 'Trip')})", user_trips_path(user)
  end

  def user_last_active_date(user)
    user.trips.last.present? ? date_short(user.trips.last.created_at) : user_join_date(user)
  end

  def user_join_date(user)
    date_short(user.created_at)
  end

end
