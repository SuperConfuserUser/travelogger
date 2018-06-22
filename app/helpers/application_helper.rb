module ApplicationHelper
  def shared_navigation
    render 'shared/navigation' if !current_page?('/')
  end
end
