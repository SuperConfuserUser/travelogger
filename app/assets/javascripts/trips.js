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
  const wrapper = $('#trips-list');
  wrapper.empty();

  let listing = $.getJSON("/trips", (trips) => {
    // format data and append to wrapper
  })
}