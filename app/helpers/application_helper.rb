module ApplicationHelper
  # LAYOUT
  def shared_navigation
    render 'shared/navigation' if !current_page?('/')
  end

  def conditional_navigation(logged_in)
    if logged_in
      render 'shared/navigation_logged_in'
    else 
      render 'shared/navigation_logged_out'
    end
  end
  
  # LINKS
  def sign_up_link
    link_to "Sign up", signup_path
  end

  def log_in_link
    link_to "Log in", login_path
  end
end
