// javascript is super weird

// the class/prototype

class Trip {
  constructor() {
  }

  // these would be great as app wide methods
  capitalize(str) {
    return str[0].toUpperCase() + str.slice(1);
  }

  listerizer(list) {
    if(list.length <= 2) {
      return list.join(" and ");
    } else {
      list[list.length - 1] = "and " + list[list.length - 1];
      return list.join(", ");
    }
  }

  longDate(sysDate) {
    const currentYear = (new Date).getFullYear();
    const date = new Date(sysDate);

    return date.getFullYear() === currentYear ?
      date.toLocaleDateString('en-us', { month: 'long', day: 'numeric' }) : // Month 1
      date.toLocaleDateString('en-us', { month: 'long', day: 'numeric', year: 'numeric' }); //Month 1, 2000
  }

  shortDate(sysDate) {
    const currentYear = (new Date).getFullYear();
    const date = new Date(sysDate);

    return date.getFullYear() === currentYear ?
      date.toLocaleDateString('en-us', { month: 'short', day: 'numeric' }) : // Mon 1
      date.toLocaleDateString('en-us', { month: 'short', day: 'numeric', year: 'numeric' }); //Mon 1, 2000
  }

  getTemplate(label) {
    return Handlebars.compile($(label).html());
  }
  // end of app wide methods

  tripDateRange() {
    return this.end_date == null ?
      this.longDate(this.start_date) :
      this.longDate(this.start_date) + " to " + this.longDate(this.end_date);
  }

  createdDate() {
    return this.shortDate(this.created_at);
  }

  userImage() {
    return this.user.image.startsWith('http') ? //checks if image is internal or external
      this.user.image :
      "/assets/" + this.user.image;             //adding path to the default image
  }

  userTripCount() {
    const count = this.user.trip_count;
    return count === 1 ?
      count + " Trip" :
      count + " Trips";
  }

  userTagline() {
    return this.user.tagline ?
      this.user.tagline :
      `<a href="/users/${this.user_id}/edit">Add tagline</a>`;
  }

  locationList() {
    const locations = this.locations.map( location => location.name );
    return this.listerizer(locations);
  }

  locationsLabel() {
    return this.locations.length > 1 ?
      "Locations" :
      "Location";
  }

  categoriesList() {
    const categoryList = [];
    for(const tc of this.trip_categories) {
      tc.description ?
        categoryList.push(this.capitalize(tc.category_name) + ": " + tc.description + "") :
        categoryList.push(this.capitalize(tc.category_name));
    }
    return this.listerizer(categoryList);
  }

  categoriesLabel() {
    return this.trip_categories.length > 1 ?
      "Types" :
      "Type";
  }

  renderIndexLi() {
    if(!indexTemplate) { 
      indexTemplate = this.getTemplate("#trip-index-li-template"); 
    }
    const context = { trip: this, userImage: this.userImage(), locations: this.locationList(), date: this.tripDateRange() };
    return indexTemplate(context);
  }

  renderShow() {
    if(!showTemplate) {
      showTemplate = this.getTemplate('#trip-show-template');
    }
    const context = { trip: this, userImage: this.userImage(), locations: this.locationList(), date: this.tripDateRange(), categories: this.categoriesList(), created_date: this.createdDate(), userTripCount: this.userTripCount(), userTagline: this.userTagline(), locationsLabel: this.locationsLabel(), categoriesLabel: this.categoriesLabel() };
    return showTemplate(context);
  }

  renderPagerButtons() {
    return "tripList: " + tripList;
  }
}

const startTripShow = () => {
  if(tripList.length) {
    loadTripShow();
  } else {
    getTripList();
  }
}

const getTripList = () => {
  console.log("list");
  const path = window.location.pathname;
  const listPath =  path.substring(0, path.lastIndexOf("/")) //cuts off trip id for index path
  $.getJSON(listPath, (trips) => {
    tripList = trips.map(trip => trip.id);
  }).done(() => loadTripShow())
}

const loadTripShow = (path = getPath()) => {
  console.log("show");

  const $container = $('section#trip-show-container');
  $container.empty();
  $.getJSON(path, json => {
    const trip = Object.assign(new Trip, json);
    $container.append(trip.renderShow());
    $container.append(trip.renderPagerButtons());
  })
}

// globals to store things

let indexTemplate,
    showTemplate,
    tripList = [];

// assign page specific behavior on document.ready

$(() => {
  const page = $('section').attr('data-page');

  switch(page) {
    case 'trips-index':
      attachTripIndexFilterListeners();
      setTripCurrentFilter();
      loadTripsIndex();
      break;
    case 'trips-show':
      startTripShow();
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

// general

const getPath = () => {
  return window.href;
}

const setPath = (path) => {
  window.location.href = path.toString();
}

// index

const attachTripIndexFilterListeners = () => {
  filters().on('click', (e) => {
    const filterPath = e.target.attributes.href.value;
    e.preventDefault();
    setTripCurrentFilter(e.target);
    loadTripsIndex(filterPath);
  })
}

const filters = () => {
  return $('a.trip-category');
}

const setTripCurrentFilter = (current = 'a#default-selection') => {
  for(const filter of filters()) {
    $(filter).removeClass("current")
  }
  $(current).addClass("current")
}

const loadTripsIndex = (path = getPath()) => {
  const $container = $('ul#trips-list');
  $container.empty();
  tripList = [];
  
  $.getJSON(path, trips => {
    trips.forEach( response => {
      const trip = Object.assign(new Trip, response);
      $container.append(trip.renderIndexLi());
      tripList.push(trip.id);
    })
  })
    .done(() => attachTripIndexLiListeners())
}

const attachTripIndexLiListeners = () => {
  $('a.list-title').on('click', (e) => {
    const path = e.target.pathname;
    e.preventDefault();
    setTripShow();
    loadTripShow(path);
  })
}

// show

const setTripShow = () => {
  $('section').attr('data-page','trips-show');
  $('section').attr('id', 'trip-show-container')
}



const attachTripShowListeners = () => {
  $('.prev, .next').on('click', function (e) {
    e.preventDefault();
    debugger
    runTest();
  })
}

