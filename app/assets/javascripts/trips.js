// javascript is super weird

// the class/prototype

class Trip {
  constructor() {

  }

  foobar() {
    console.log(this);
  }
}


// assign page specific behavior on document.ready

$(() => {
  const page = $('section').attr('data-page');

  switch(page) {
    case "trips-index":
      loadTripsIndex();
      break;
    case "trips-show":
      alert("I'm in " + page)
      break;
    case "trips-form":
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
  $wrapper.empty();

  const listing = $.getJSON("/trips", (trips) => {
    let html = "";
    trips.forEach(json => {
      const trip = Object.assign(new Trip, json);
       html += `<li>${trip.name}</li>`;
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