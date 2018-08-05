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
      return date.toLocaleDateString('en-us', { month: 'long', day: 'numeric' }); // Month 1
    } else {
      return date.toLocaleDateString('en-us', { month: 'long', day: 'numeric', year: 'numeric' }); //Month 1, 2000
    }
  }

  tripDateRange() {
    if (this.end_date == null) {
      return this.longDate(this.start_date);
    } else {
      return this.longDate(this.start_date) + " to " + this.longDate(this.end_date);
    }
  }

  userImage() {
    if(this.user.image.startsWith('http')) {
      return this.user.image;
    } else {
      return "/assets/" + this.user.image;   //adding full path to the default image
    }
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

  renderIndexLi() {
    const template = Handlebars.compile($('#trip-index-li-template').html());
    const context = { id: this.id, userId: this.user_id, userImage: this.userImage(), name: this.name, userUserName: this.user.username, locations: this.locationList(), date: this.tripDateRange() };
    return template(context);
  }
}


// assign page specific behavior on document.ready

$(() => {
  const page = $('section').attr('data-page');

  switch(page) {
    case 'trips-index':
      attachTripIndexListeners();
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
  alert("clicked!");
}


// index

const attachTripIndexListeners = () => {
    $('a.trip-category').on('click', function (e) {  //using old skool function for specific this binding
    const filterPath = this.attributes.href.value;
    e.preventDefault();
    loadTripsIndex(filterPath);
  })
}

const loadTripsIndex = (indexPath = window.location.pathname + window.location.search) => {
  const $container = $('ul#trips-list');
  $container.empty();
  
  $.getJSON(indexPath, trips => {
    trips.forEach( json => {
      const trip = Object.assign(new Trip, json);
      $container.append(trip.renderIndexLi());
    })
  })
}