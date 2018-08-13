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
    # add_trip_link = link_to "+", new_user_trip_path(current_user), class: "add-trip" if logged_in?
    add_trip_link = link_to "New Trip", new_user_trip_path(current_user), class: "link-as-button" if logged_in?
    if user 
      add_trip_link if authorized?(user) 
    else
      add_trip_link if logged_in?
    end
  end

  def trip_label(trip)
    if nested?
      trip_location_list(trip)
    else
      render layout: 'users/user_name_link', locals: { user: trip.user, klass: "camo-link strong" } do
        " " + trip_location_list(trip)
      end
    end 
  end 
  

  #SHOW
  def trip_location_label(trip)
    "Location".pluralize(trip.locations.count)
  end

  def trip_location_list(trip)
    locations = trip.locations.pluck('name')
    if locations.count <= 2
      locations.join(" and ")
    else
      locations.last.prepend("and ")
      locations.join(", ")
    end
  end

  def trip_date_range(trip)
    if trip.end_date.present?
      date_long(trip.start_date) + " to " + date_long(trip.end_date)
    else
      date_long(trip.start_date)
    end
  end

  def trip_type_label(trip)
    "Type".pluralize(trip.locations.count - 1)
  end

  def trip_type_list(trip)
    trip.categories.pluck('name').map { |name| name.capitalize }.join(', ')
  end

  def trip_edit_link(trip, klass)
    link_to "Edit", edit_user_trip_path(trip.user, trip), class: klass
  end

  def trip_delete_link(trip, klass)
    link_to "Delete", trip, method: :delete, class: klass
  end

end
