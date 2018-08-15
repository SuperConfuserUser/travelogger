# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
      /app/assets/javascripts/trips.js
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
      trip_controller.rb line 18-23
      trips.js line 246-303
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
      trip_controller.rb line 8-16
      trips.js line 192-243
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
      trip.rb line 7 - Trip has many Locations
      trip.js line 248 - Trip.prototype.renderShow()
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh.
      trip_controller line 30-39
      trip.js line 308-330
- [x] Translate JSON responses into js model objects.
      trip.js line 269-277
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
      trip.js line 59-63 Trip.prototype.tripDateRange()

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message

