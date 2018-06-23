module TripsHelper
  #INDEX
  def trips_index_title(user)
    username = authorized?(user) ? "I've" : "#{user.username} has" if user
    user ? "The Things #{username} Seen" : "The Places We've Been"
  end

  def trips_all_link(user)
    user ? user_trips_path(user) : trips_path
  end

  def trips_category_filter_link(user, category_name)
    user ? user_trips_path(user, category: category_name) : trips_path(category: category_name)
  end

  def add_trip_link(user)
    add_trip_link = link_to "New trip", new_user_trip_path(current_user), class: "add-trip" if logged_in?
    if user 
      add_trip_link if authorized?(user) 
    else
      add_trip_link if logged_in?
    end
  end
  
end
