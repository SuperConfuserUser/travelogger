// javascript is super weird

// the class/prototype

class Trip {
  constructor() {

  }

  // this would ideally be in app.js
  longDate(sysDate) {
    const currentYear = (new Date).getFullYear();
    const date = new Date(sysDate);

    return date.getFullYear() === currentYear ?
      date.toLocaleDateString('en-us', { month: 'long', day: 'numeric' }) : // Month 1
      date.toLocaleDateString('en-us', { month: 'long', day: 'numeric', year: 'numeric' }); //Month 1, 2000
  }

  tripDateRange() {
    return this.end_date == null ?
      this.longDate(this.start_date) :
      this.longDate(this.start_date) + " to " + this.longDate(this.end_date);
  }

  userImage() {
    return this.user.image.startsWith('http') ? //checks if image is internal or external
      this.user.image :
      "/assets/" + this.user.image;             //adding path to the default image
  }

  locationList() {
    const locations = this.locations.map( location => location.name );
    
    if(locations.length <= 2) {
      return locations.join(" and ");
    } else {
      locations[locations.length - 1] = "and " + locations[locations.length - 1];
      return locations.join(", ");
    }
  }

  categoriesList() {
    return 'whee';
  }

  createdDate() {
    return 'whee';
  }

  userTripCount() {
    return 'whee';
  }

  userTagline() {
    return this.user.tagline ?
      this.user.tagline :
      `<a href="/users/${this.user_id}/edit">Add tagline</a>`;
  }

  renderIndexLi() {
    const template = Handlebars.compile($('#trip-index-li-template').html());
    const context = { trip: this, userImage: this.userImage(), locations: this.locationList(), date: this.tripDateRange() };
    return template(context);
  }

  renderShow() {
    const template = Handlebars.compile($('#trip-show-template').html());
    const context = { trip: this, userImage: this.userImage(), locations: this.locationList(), date: this.tripDateRange(), categories: this.categoriesList(), created_date: this.createdDate(), userTripCount: this.userTripCount(), userTagline: this.userTagline() };
    return template(context);
  }
}


// assign page specific behavior on document.ready

$(() => {
  const page = $('section').attr('data-page');

  switch(page) {
    case 'trips-index':
      attachTripIndexListeners();
      setTripCurrentFilter();
      loadTripsIndex();
      break;
    case 'trips-show':
      loadTripsShow();
      // attachTripShowListeners();
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
  alert("clicked!");
}


// index

const filters = () => {
  return $('a.trip-category');
}

const attachTripIndexListeners = () => {
    filters().on('click', function (e) {  //using old skool function for specific this binding
    const filterPath = this.attributes.href.value;
    e.preventDefault();
    setTripCurrentFilter(this)
    loadTripsIndex(filterPath);
  })
}

const setTripCurrentFilter = (current = 'a#default-selection') => {
  for(const filter of filters()) {
    $(filter).removeClass("current")
  }

  $(current).addClass("current")
}

const loadTripsIndex = (path = window.location.pathname + window.location.search) => {
  debugger
  const $container = $('ul#trips-list');
  $container.empty();

  $.getJSON(path, trips => {
    trips.forEach( json => {
      const trip = Object.assign(new Trip, json);
      $container.append(trip.renderIndexLi());
    })
  })
}

// show

const attachTripShowListeners = () => {

  $('.prev, .next').on('click', function (e) {
    e.preventDefault();
    debugger
    runTest();
  })
}

const loadTripsShow = (path = window.location.pathname + window.location.search) => {
  const $container = $('section#trip-show-container');
  // $container.empty();

  $.getJSON(path, json => {
      const trip = Object.assign(new Trip, json);
      $container.append(trip.renderShow());
  })
}