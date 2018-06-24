module ApplicationHelper
  # LAYOUT
  def shared_navigation
    render 'shared/navigation' if !current_page?('/')
  end

  def conditional_navigation
    if logged_in?
      render 'shared/navigation_logged_in'
    else 
      render 'shared/navigation_logged_out'
    end
  end

  def trips_navigation_link
    logged_in? ? user_trips_path(current_user) : trips_path
  end  

  def shared_alert(flash_alert)
    render 'shared/alert', flash_alert: flash_alert if flash_alert
  end

  # LINKS
  def sign_up_link
    link_to "Sign up", signup_path
  end

  def log_in_link
    link_to "Log in", login_path
  end

  #DATES
  def current_year?(date)
    date.year == Date.today.year
  end

  def date_long(date) #Month 1, 2000
    current_year?(date) ? date.strftime("%B %e") : date.strftime("%B %e, %Y")
  end

  def date_short(date) #Mon 1, 2000
    current_year?(date) ? date.strftime("%b %e") : date.strftime("%b %e, %Y") 
  end

end
