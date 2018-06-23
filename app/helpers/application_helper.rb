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

  
  # LINKS
  def sign_up_link
    link_to "Sign up", signup_path
  end

  def log_in_link
    link_to "Log in", login_path
  end

  #DATES
  def date_long(date)
    date.strftime("%B %e, %Y") #Month 00, 0000
  end
  
end
