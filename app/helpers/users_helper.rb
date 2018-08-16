module UsersHelper
  #FORM
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

  def user_form_reset_button(user)
    link_to "Reset", edit_user_path(user), class: "link-as-button ghost" if user.persisted?
  end

  #INDEX and SHOW
  def user_trips_count(user)
    pluralize(user.trips.count, 'Trip')
  end

  def user_trips_count_link(user)
    link_to "(#{user_trips_count(user)})", user_trips_path(user)
  end

  def user_last_active_date(user)
    user.trips.last.present? ? user.trips.last.created_at : user_join_date(user)
  end

  def user_join_date(user)
    user.created_at
  end

  #SHOW
  def user_tagline(user)
    if user.tagline?
      user.tagline
    elsif authorized?(user)
      link_to "Add tagline", edit_user_path(user)
    else
      "A traveller. A wanderer."
    end
  end

  def user_profile(user)
    if user.profile?
      user.profile
    else 
      link_to "Add profile", edit_user_path(user) if authorized?(user)
    end 
  end

  def user_more_trips_link(user, latest_limit)
    link_to "More trips", user_trips_path(user) if user.trips.count > latest_limit
  end

  def user_latest_trips(user, latest_limit)
    if user.trips.any?
      render "users/user_show_trips_listing", user: user, latest_limit: latest_limit 
    elsif user.profile.nil?
      content_tag :p, "Nothing to see here."
    end
  end

  def user_edit_link(user, klass)
    link_to "Edit account", edit_user_path(current_user), class: klass if authorized?(user)
  end

end

