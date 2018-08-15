// javascript is super weird

// the CLASS/prototype

class Trip {
  constructor() {
  }

  // these would be great as APP wide methods

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
    const currentYear = (new Date).getFullYear(),
          date = new Date(sysDate);

    return date.getFullYear() === currentYear ?
      date.toLocaleDateString('en-us', { month: 'long', day: 'numeric' }) : // Month 1
      date.toLocaleDateString('en-us', { month: 'long', day: 'numeric', year: 'numeric' }); //Month 1, 2000
  }

  shortDate(sysDate) {
    const currentYear = (new Date).getFullYear(),
          date = new Date(sysDate);

    return date.getFullYear() === currentYear ?
      date.toLocaleDateString('en-us', { month: 'short', day: 'numeric' }) : // Mon 1
      date.toLocaleDateString('en-us', { month: 'short', day: 'numeric', year: 'numeric' }); //Mon 1, 2000
  }

  getTemplate(label) {
    return Handlebars.compile($(label).html());
  }

  // PROTOTYPE METHODS specific to trip, for now

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

  pageNav() {
    const current = tripList.indexOf(this.id);
    let buttons = {}

    if(current) {
      buttons.prev = tripList[current - 1];
    }
    if(current < tripList.length - 1) {
      buttons.next = tripList[current + 1];
    }
    return buttons;
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
    const buttons = this.pageNav(),
          context = { trip: this, userImage: this.userImage(), locations: this.locationList(), date: this.tripDateRange(), categories: this.categoriesList(), created_date: this.createdDate(), userTripCount: this.userTripCount(), userTagline: this.userTagline(), locationsLabel: this.locationsLabel(), categoriesLabel: this.categoriesLabel(), prevTrip: buttons.prev, nextTrip: buttons.next };
    return showTemplate(context);
  }

  renderTripList() {
    return "<br>tripList: " + tripList;
  }
}


// GLOBALS to store things. there should be a better way v.v

let indexTemplate,
    showTemplate,
    tripList = [];



// assign PAGE specific behavior on document.ready

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
      break;
    case 'trips-form':
      attachTripSubmit();
      break;
  }
})

const attachTripSubmit = () => {
  $('form#new_trip').on('submit', (e) => {
    e.preventDefault();

    $.ajax({
      type: "POST",
      url: e.target.action,
      data: $(e.target).serialize(),
      dataType: "json"
    })
      .done((trip) => {
      })
      .fail((response) => {
      })    
  })
}


// GENERAL

const getPath = () => {
  return window.href;
}

const setPath = (path) => {
  history.pushState("", "", path);
}


// INDEX

const attachTripIndexFilterListeners = () => {
  filters().on('click', (e) => {
    const filterPath = e.target.attributes.href.value;
    setPath(filterPath);
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
  tripList = [];
  
  $.getJSON(path, trips => {
    if(!trips.length) {
      $container.empty();
    } 
    trips.forEach( response => {
      const trip = Object.assign(new Trip, response);
      tripList.push(trip.id);
      if(tripList.length === 1) {
        $container.html(trip.renderIndexLi());
      } else {
        $container.append(trip.renderIndexLi());
      }
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


// SHOW

const startTripShow = () => {
  if(tripList.length) {
    loadTripShow();
  } else {
    getTripList();
  }
}

const setTripShow = () => {  //dynamic rendering from another page
  $('section').attr('data-page','trips-show');
  $('section').attr('id', 'trip-show-container')
}

const getTripList = (callback = loadTripShow) => {
  const path = window.location.pathname,
        listPath =  path.substring(0, path.lastIndexOf("/")) //cuts off trip id for index path
  $.getJSON(listPath, (trips) => {
    tripList = trips.map(trip => trip.id);
  }).done(() => callback())
}

const loadTripShow = (path = getPath()) => {
  const $container = $('section#trip-show-container');
  setPath(path);
  $.getJSON(path, json => {
    const trip = Object.assign(new Trip, json);
    $container.html(trip.renderShow());
    renderAuthorizedContainer(trip.id, trip.user_id);
  })
    .done(() => attachPageNavListeners())
}

const attachPageNavListeners = () => {
  $('a.prev, a.next').on('click', function (e) {
    e.preventDefault();
    const path = this.attributes.href.value;
    console.log(path);
    loadTripShow(path);
  })
} }).done(() => callback())
}

const loadTripShow = (path = getPath()) => {
  const $container = $('section#trip-show-container');
  setPath(path);
  $.getJSON(path, json => {
    const trip = Object.assign(new Trip, json);
    $container.html(trip.renderShow());
    renderAuthorizedContainer(trip.id, trip.user_id);
  })
    .done(() => attachPageNavListeners())
}

const attachPageNavListeners = () => {
  $('a.prev, a.next').on('click', function (e) {
    e.preventDefault();
    const path = this.attributes.href.value;
    console.log(path);
    loadTripShow(path);
  })
}

const renderAuthorizedContainer = (tripId, userId) => {
  const $container = $('div#authorizedContainer'),
        currentUser = $container.attr('data-user');
  if(userId.toString() === currentUser) {
    $container.html(`
    <br><br>
    <a class="link-as-button ghost" href="/users/${userId}/trips/${tripId}/edit">Edit</a>
    <a class="link-as-button ghost" rel="nofollow" data-method="delete" href="/trips/${tripId}">Delete</a> 
    `);
  }
}