// // javascript is super weird

// // the class/prototype
// let tripList = [];

// class Trippy {
//   constructor() {
//   }

//   // these would ideally be in app.js
//   capitalize(str) {
//     return str[0].toUpperCase() + str.slice(1);
//   }

//   listerizer(list) {
//     if(list.length <= 2) {
//       return list.join(" and ");
//     } else {
//       list[list.length - 1] = "and " + list[list.length - 1];
//       return list.join(", ");
//     }
//   }

//   longDate(sysDate) {
//     const currentYear = (new Date).getFullYear();
//     const date = new Date(sysDate);

//     return date.getFullYear() === currentYear ?
//       date.toLocaleDateString('en-us', { month: 'long', day: 'numeric' }) : // Month 1
//       date.toLocaleDateString('en-us', { month: 'long', day: 'numeric', year: 'numeric' }); //Month 1, 2000
//   }

//   shortDate(sysDate) {
//     const currentYear = (new Date).getFullYear();
//     const date = new Date(sysDate);

//     return date.getFullYear() === currentYear ?
//       date.toLocaleDateString('en-us', { month: 'short', day: 'numeric' }) : // Mon 1
//       date.toLocaleDateString('en-us', { month: 'short', day: 'numeric', year: 'numeric' }); //Mon 1, 2000
//   }

//   tripDateRange() {
//     return this.end_date == null ?
//       this.longDate(this.start_date) :
//       this.longDate(this.start_date) + " to " + this.longDate(this.end_date);
//   }

//   createdDate() {
//     return this.shortDate(this.created_at);
//   }

//   userImage() {
//     return this.user.image.startsWith('http') ? //checks if image is internal or external
//       this.user.image :
//       "/assets/" + this.user.image;             //adding path to the default image
//   }

//   userTripCount() {
//     const count = this.user.trips.length;
//     return count === 1 ?
//       count + " Trip" :
//       count + " Trips";
//   }

//   userTagline() {
//     return this.user.tagline ?
//       this.user.tagline :
//       `<a href="/users/${this.user_id}/edit">Add tagline</a>`;
//   }

//   locationList() {
//     const locations = this.locations.map( location => location.name );
//     return this.listerizer(locations);
//   }

//   categoriesList() {
//     const categoryList = [];
//     for(const category of this.categories) {
//       for(const tc of this.trip_categories) {
//         tc.category_id === category.id && tc.description ?
//           categoryList.push(this.capitalize(category.name) + ": " + tc.description + "") :
//           categoryList.push(this.capitalize(category.name));
//       }
//     }
//     return this.listerizer(categoryList);
//   }

//   locationsLabel() {
//     return this.locations.length > 1 ?
//       "Locations" :
//       "Location";
//   }

//   categoriesLabel() {
//     return this.categories.length > 1 ?
//       "Types" :
//       "Type";
//   }

//   currentTrip() {
//     // if(!list) {
//     //   getList(); //build this out later
//     // }
//     return tripList.indexOf(this.id);
//   }

//   prevTrip() {
//     const current = this.currentTrip();
//     if(current !== 0) {
//       return tripList[current - 1];
//     }
//   }

//   nextTrip() {
//     const current = this.currentTrip();
//     const last = tripList.length - 1;
//     if(current < last) {
//       return tripList[current + 1];
//     }
//   }

//   renderIndexLi() {
//     const template = Handlebars.compile($('#trip-index-li-template').html());
//     const context = { trip: this, userImage: this.userImage(), locations: this.locationList(), date: this.tripDateRange() };
//     return template(context);
//   }

//   renderShow() {
//     const template = Handlebars.compile($('#trip-show-template').html());
//     const context = { trip: this, userImage: this.userImage(), locations: this.locationList(), date: this.tripDateRange(), categories: this.categoriesList(), created_date: this.createdDate(), userTripCount: this.userTripCount(), userTagline: this.userTagline(), locationsLabel: this.locationsLabel(), categoriesLabel: this.categoriesLabel(), prevTrip: this.prevTrip(), nextTrip: this.nextTrip() };
//     return template(context);
//   }
// }


// // assign page specific behavior on document.ready

// $(() => {
//   const page = $('section').attr('data-page');

//   switch(page) {
//     case 'trips-index':
//       attachTripIndexListeners();
//       setTripCurrentFilter();
//       loadTripsIndex();
//       break;
//     case 'trips-show':
//         // getTripList(); 
//       loadTripsShow();
//       // attachTripShowListeners();
//       break;
//     case 'trips-form':
//       alert("I'm in " + page)
//       break;
//   }
// })


// //play code 

// const attachListeners = () => {
//   $('#hide_this').on('click', () => hideWhenClicked('#hide_this'));
//   $('#test').on('click', runTest);
// }

// $(attachListeners);

// const hideWhenClicked = el => $(el).hide();

// function runTest() {
//   alert("clicked!");
// }


// // index

// const filters = () => {
//   return $('a.trip-category');
// }

// const attachTripIndexListeners = () => {
//     filters().on('click', function (e) {  //using old skool function for specific this binding
//     const filterPath = this.attributes.href.value;
//     e.preventDefault();
//     setTripCurrentFilter(this)
//     loadTripsIndex(filterPath);
//   })
// }

// const setTripCurrentFilter = (current = 'a#default-selection') => {
//   for(const filter of filters()) {
//     $(filter).removeClass("current")
//   }
//   $(current).addClass("current")
// }

// const getPath = () => {
//   return window.location.pathname + window.location.search;
// }

// const loadTripsIndex = (path = getPath()) => {
//   const $container = $('ul#trips-list');
//   $container.empty();
//   let list = [];

//   $.getJSON(path, trips => {
//     trips.forEach( response => {
//       const trip = Object.assign(new Trip, response);
//       $container.append(trip.renderIndexLi());
//       // list.push(trip.id);
//     })
//   })  
//   // listing.done(() => {
//   //   $(a.list-title).on("click", function (e) {
//   //     e.preventDefault();
//   //     const tripPath = this.attributes.href.value;
//   //     setTripShowContainer();
//   //     loadTripsShow(tripPath);
//   //   })

//   // list = trips.map(trip => trip.id)
// }


// // show

// const getTripList = (path = "/trips.json") => {
//     const prevList = tripList;
//     $.getJSON(path, trips => {
//       tripList = trips.map(trip => trip.id);
//       console.log("tripList: " + tripList)
//     })
//       .done(() => {
//         if(prevList !== tripList) { 
//           loadTripsShow() 
//         }
//   })
// }

// const loadTripsShow = (path = getPath()) => {
//   const $container = $('section#trip-show-container');
//   $container.empty();
//   $.getJSON(path, json => {
//       const trip = Object.assign(new Trip, json);
//       $container.append(trip.renderShow());
//   })
//     .done(() => attachTripShowListeners())
// }

// const attachTripShowListeners = () => {
//   console.log("attachListeners")
//   $('.prev, .next').on('click', function (e) {
//     e.preventDefault();
//     const path = this.attributes.href.value;
//     location.href = path;
//     loadTripsShow(path);
//   })
// }