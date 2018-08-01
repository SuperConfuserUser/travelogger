// javascript is super weird

const attachListeners = () => {
  $('#hide_this').on('click', () => hideWhenClicked('#hide_this'));
  $('#test').on('click', () => alert("whee!"));
}

$(attachListeners);

const hideWhenClicked = el => $(el).hide();