// javascript is super weird

// the class/prototype

class Trip {
  constructor() {
    
  }

  // this would ideally be in app.js
  longDate(sysDate) {
    const currentYear = (new Date).getFullYear();
    const date = new Date(sysDate);
    
    if(date.getFullYear() === currentYear) {
      return date.toLocaleDateString('en-us', { month: 'long', day: 'numeric' }); //Month 1
    } else {
      return date.toLocaleDateString('en-us', { month: 'long', day: 'numeric', year: 'numeric' }); //Month 1, 2000
    }
  }

  tripDateRange() {
    debugger
    if (this.end_date == null) {
      return this.longDate(this.start_date);
    } else {
      return this.longDate(this.start_date) + " to " + this.longDate(this.end_date);
    }
  }

  userImage() {
    debugger
    if(this.user.image.startsWith('http')) {
      return this.user.image;
    } else {
      return "/assets/" + this.user.image;
    }
  }

  renderIndexLi() {
    const source   = $('#trip-index-li-template').html();
    const template = Handlebars.compile(source);
    const context = { id: this.id, userId: this.user_id, userImage: this.userImage(), name: this.name, userUserName: this.user.username, locations: this.locations, date: this.tripDateRange() };
    const html    = template(context);
    return html;
  }
}


// assign page specific behavior on document.ready

$(() => {
  const page = $('section').attr('data-page');

  switch(page) {
    case 'trips-index':
      loadTripsIndex();
      break;
    case 'trips-show':
      alert("I'm in " + page)
      break;
    case 'trips-form':
      alert("I'm in " + page)
      break;
  }
})


//play code 

const attachListeners = () => {
  $('#hide_this').on('click', () => hideWhenClicked('#hide_this'));
  $('#test').on('click', runTest);
}

$(attachListeners);

const hideWhenClicked = el => $(el).hide();

function runTest() {
  let a = new Trip;
  return a.foobar();
}


// index

const loadTripsIndex = () => {
  const $wrapper = $('#trips-list');
  // $wrapper.empty();

  const listing = $.getJSON('/trips', (trips) => {
    let html = "";
    trips.forEach(json => {
      const trip = Object.assign(new Trip, json);
        html += trip.renderIndexLi();
      })
    $wrapper.append(html);
  })
}

{/* <li>
  <%= render 'users/user_avatar_link', user: trip.user, klass: "list-avatar" %>

  <div class="list-description">
    <%= link_to trip.name, user_trip_path(trip.user, trip), class: "list-title" %>
    <%= trip_label(trip) %>
     on <%= date_long(trip.start_date) %>
  </div><!-- list-description -->
</li> */}

// nested options for links and trip label
// def trip_label(trip)
//     if nested?
//       trip_location_list(trip)
//     else
//       render layout: 'users/user_name_link', locals: { user: trip.user, klass: "camo-link strong" } do
//         " " + trip_location_list(trip)
//       end
//     end 
//   end 