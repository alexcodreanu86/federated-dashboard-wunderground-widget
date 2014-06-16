(function() {
  namespace('Weather');

  Weather.Controller = (function() {
    function Controller() {}

    Controller.bind = function() {
      return $('[data-id=weather-button]').click((function(_this) {
        return function() {
          return _this.getCurrentWeather(Weather.View.getInput());
        };
      })(this));
    };

    Controller.getCurrentWeather = function(zipcode) {
      return Weather.API.getCurrentConditions(zipcode, Weather.View.showWeather);
    };

    Controller.setupWidgetIn = function(container, apiKey) {
      Weather.View.displayFormIn(container);
      Weather.API.key = apiKey;
      return this.bind();
    };

    return Controller;

  })();

}).call(this);
