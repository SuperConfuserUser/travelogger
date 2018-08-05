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

// play code

function runTest() {
  let a = new Trip;
  return a.foobar();
}

const attachListeners = () => {
  $('#hide_this').on('click', () => hideWhenClicked('#hide_this'));
  $('#test').on('click', testClass);
}

$(attachListeners);

const hideWhenClicked = el => $(el).hide();

// assign page specific behavior on document.ready

$(() => {
  const page = $('section').attr('data-page');

  switch(page) {
    case "trips-index":
      alert("I'm in " + page)
      break;
    case "trips-show":
      alert("I'm in " + page)
      break;
    case "trips-form":
      alert("I'm in " + page)
      break;
  }
})

// index

const loadTripsIndex = () => {
  const wrapper = $('#trips-list');
  wrapper.empty();

  let listing = listing || $.getJSON("/trips", (trips) => {
    // set data and templates now
  })
}