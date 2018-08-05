// javascript is super weird

// the class/prototype

class Trip {
  constructor() {
    this.foo = "bar";
  }

  foobar() {
    alert(this.foo);
  }
}

function testClass() {
  let a = new Trip;
  return a.foobar();
}

$(testClass);

// DOM

const attachListeners = () => {
  $('#hide_this').on('click', () => hideWhenClicked('#hide_this'));
  $('#test').on('click', testClass);
}

$(attachListeners);

const hideWhenClicked = el => $(el).hide();

// index
// do this on doc ready? should JS be separated for each Trip page (index, show, create)
const loadTripsIndex = () => {
  const wrapper = $('#trips-list');
  wrapper.empty();

  let listing = listing || $.getJSON("/trips", (trips) => {
    // set data and templates now
  })
}